// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Escrow {
    enum Status {
        Draft,
        Active,
        Completed,
        Canceled,
        Disputed
    }

    enum MilestoneStatus {
        Pending,
        Released
    }

    struct Milestone {
        uint256 amount;
        uint256 dueDate;
        MilestoneStatus status;
    }

    struct Agreement {
        address payable vendor;
        address payable client;
        address mediator;
        IERC20 token;
        uint256 totalAmount;
        uint256 balance;
        Status status;
        Milestone[] milestones;
        mapping(uint256 => bool) releasedMilestones;
        uint256 refundPolicy; // Simple refund window in days
        uint256 creationDate;
    }

    mapping(bytes32 => Agreement) public agreements;

    event AgreementCreated(bytes32 indexed agreementId);
    event Deposited(bytes32 indexed agreementId, uint256 amount);
    event MilestoneReleased(bytes32 indexed agreementId, uint256 milestoneIndex, uint256 amount);
    event Canceled(bytes32 indexed agreementId, uint256 refundAmount);
    event DisputeOpened(bytes32 indexed agreementId);
    event DisputeResolved(bytes32 indexed agreementId, uint256 vendorAmount, uint256 clientAmount);

    function createAgreement(
        bytes32 agreementId,
        address payable _vendor,
        address payable _client,
        address _mediator,
        IERC20 _token,
        uint256[] memory _milestoneAmounts,
        uint256[] memory _milestoneDueDates,
        uint256 _refundPolicy
    ) public {
        require(agreements[agreementId].vendor == address(0), "Agreement already exists");
        require(_vendor != address(0) && _client != address(0), "Invalid parties");
        require(_milestoneAmounts.length == _milestoneDueDates.length, "Milestone data mismatch");

        Agreement storage newAgreement = agreements[agreementId];
        newAgreement.vendor = _vendor;
        newAgreement.client = _client;
        newAgreement.mediator = _mediator;
        newAgreement.token = _token;
        newAgreement.status = Status.Draft;
        newAgreement.refundPolicy = _refundPolicy;
        newAgreement.creationDate = block.timestamp;

        uint256 totalAmount = 0;
        for (uint i = 0; i < _milestoneAmounts.length; i++) {
            newAgreement.milestones.push(Milestone({
                amount: _milestoneAmounts[i],
                dueDate: _milestoneDueDates[i],
                status: MilestoneStatus.Pending
            }));
            totalAmount += _milestoneAmounts[i];
        }

        newAgreement.totalAmount = totalAmount;

        emit AgreementCreated(agreementId);
    }

    function deposit(bytes32 agreementId) public {
        Agreement storage agreement = agreements[agreementId];
        require(agreement.status == Status.Draft, "Agreement not in draft state");
        require(msg.sender == agreement.client, "Only client can deposit");

        uint256 totalAmount = agreement.totalAmount;
        agreement.token.transferFrom(msg.sender, address(this), totalAmount);
        agreement.balance = totalAmount;
        agreement.status = Status.Active;

        emit Deposited(agreementId, totalAmount);
    }

    function releaseMilestone(bytes32 agreementId, uint256 milestoneIndex) public {
        Agreement storage agreement = agreements[agreementId];
        require(msg.sender == agreement.client, "Only client can release milestones");
        require(agreement.status == Status.Active, "Agreement not active");
        require(milestoneIndex < agreement.milestones.length, "Invalid milestone index");
        require(agreement.milestones[milestoneIndex].status == MilestoneStatus.Pending, "Milestone already released");

        Milestone storage milestone = agreement.milestones[milestoneIndex];
        uint256 amount = milestone.amount;

        agreement.balance -= amount;
        milestone.status = MilestoneStatus.Released;
        agreement.releasedMilestones[milestoneIndex] = true;

        agreement.token.transfer(agreement.vendor, amount);

        emit MilestoneReleased(agreementId, milestoneIndex, amount);

        bool allMilestonesReleased = true;
        for (uint i = 0; i < agreement.milestones.length; i++) {
            if (agreement.milestones[i].status == MilestoneStatus.Pending) {
                allMilestonesReleased = false;
                break;
            }
        }

        if (allMilestonesReleased) {
            agreement.status = Status.Completed;
        }
    }

    function cancel(bytes32 agreementId) public {
        Agreement storage agreement = agreements[agreementId];
        require(msg.sender == agreement.client, "Only client can cancel");
        require(agreement.status == Status.Active, "Agreement not active");
        require(block.timestamp <= agreement.creationDate + (agreement.refundPolicy * 1 days), "Refund window expired");

        uint256 refundAmount = agreement.balance;
        agreement.balance = 0;
        agreement.status = Status.Canceled;

        agreement.token.transfer(agreement.client, refundAmount);

        emit Canceled(agreementId, refundAmount);
    }

    function openDispute(bytes32 agreementId) public {
        Agreement storage agreement = agreements[agreementId];
        require(msg.sender == agreement.vendor || msg.sender == agreement.client, "Only parties can open a dispute");
        require(agreement.status == Status.Active, "Agreement not active");

        agreement.status = Status.Disputed;

        emit DisputeOpened(agreementId);
    }

    function resolveDispute(bytes32 agreementId, uint256 vendorAmount, uint256 clientAmount) public {
        Agreement storage agreement = agreements[agreementId];
        require(msg.sender == agreement.mediator, "Only mediator can resolve disputes");
        require(agreement.status == Status.Disputed, "Agreement not in dispute");
        require(vendorAmount + clientAmount == agreement.balance, "Amounts don't match balance");

        agreement.balance = 0;
        agreement.status = Status.Completed;

        agreement.token.transfer(agreement.vendor, vendorAmount);
        agreement.token.transfer(agreement.client, clientAmount);

        emit DisputeResolved(agreementId, vendorAmount, clientAmount);
    }

    function getAgreement(bytes32 agreementId)
        public
        view
        returns (
            address,
            address,
            address,
            address,
            uint256,
            uint256,
            Status,
            uint256,
            uint256
        )
    {
        Agreement storage agreement = agreements[agreementId];
        return (
            agreement.vendor,
            agreement.client,
            agreement.mediator,
            address(agreement.token),
            agreement.totalAmount,
            agreement.balance,
            agreement.status,
            agreement.refundPolicy,
            agreement.creationDate
        );
    }
}

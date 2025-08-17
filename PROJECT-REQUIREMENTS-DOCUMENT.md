# FairHold - On-Chain Event Escrow Platform PRD

## Executive Summary

**Product Name**: FairHold  
**Platform**: Web Application (scaffold-eth-2)  
**Target Market**: Event planning industry (weddings, corporate events, parties)  
**Value Range**: $5K-$50K+ events with vendor deposits and milestone payments  
**Core Value Proposition**: Smart escrow for event planning with yield generation, automated milestone releases, and dispute resolution - making event payments safer and more profitable for all parties.

## 1. Product Overview

### 1.1 Problem Statement
Event planning involves high-stakes financial relationships where:
- **Couples/Clients** risk losing deposits to unreliable vendors
- **Vendors** struggle with cash flow and advance expense coverage
- **Both parties** lose money to opportunity costs on locked funds
- **Disputes** are expensive and time-consuming to resolve
- **Payment processes** are manual, opaque, and friction-heavy

### 1.2 Solution
FairHold creates a smart escrow system for event planning that:
- **Protects deposits** through MultiSig smart contracts
- **Generates yield** on escrowed funds, reducing effective costs
- **Automates milestone releases** based on deliverable completion
- **Enables vendor advance funding** for event expenses with AI risk assessment
- **Provides dispute mediation** with transparent, policy-based resolution
- **Supports non-crypto users** through seamless fiat integration

### 1.3 Success Metrics
- **Primary**: Total Value Locked (TVL) in event escrow contracts
- **Secondary**: Number of completed events, average yield generated, dispute resolution rate
- **User Experience**: Time from vendor invite to couple payment (<5 minutes)
- **Business Impact**: Percentage reduction in event planning financial disputes

## 2. Sponsor Integration Strategy

### 2.1 Dynamic Integration - Seamless Onboarding
**Purpose**: Enable non-crypto users to participate without wallet complexity

**Implementation**:
- **Embedded wallet creation** for couples via email/OTP login
- **Vendor wallet management** with simple dashboard interface
- **Magic link sharing** for contract invitations (no wallet required for initial interaction)
- **Multi-account support** for vendors managing multiple events

**User Benefits**:
- Couples can pay deposits without understanding crypto
- Vendors get professional wallet interface without technical complexity
- Seamless transition from traditional event planning workflows

### 2.2 PYUSD Integration - Stable Event Payments
**Purpose**: Reliable value storage and yield generation for event funds

**Implementation**:
- **Primary currency** for all event escrow contracts
- **Yield generation** on escrowed funds (reducing effective deposit costs)
- **Vendor advance funding** using escrowed PYUSD as collateral
- **Real-time balance tracking** across all event milestones

**User Benefits**:
- Price stability for event budget planning
- Yield earnings offset escrow opportunity costs
- Clear, USD-denominated milestone tracking

### 2.3 Fern Integration - Fiat Bridge
**Purpose**: Enable traditional payment methods while leveraging crypto benefits

**Implementation**:
- **Card/Apple Pay deposits** converting directly to PYUSD in escrow
- **Vendor payout options** (crypto to bank account)
- **Guest contribution system** for wedding registries and group funding
- **KYC handling** for large event deposits

**User Benefits**:
- Couples pay with familiar methods (credit cards, Apple Pay)
- Vendors can receive traditional bank transfers
- Wedding guests can contribute without crypto knowledge
- Compliance handling for high-value events

### 2.4 Zircuit Integration - AI-Powered Risk Management
**Purpose**: Intelligent fraud detection and risk assessment for event contracts

**Implementation**:
- **Vendor risk assessment** for advance funding eligibility
- **Unusual payment pattern detection** (potential fraud or disputes)
- **Contract behavior monitoring** (milestone timing, communication patterns)
- **Dispute prediction** based on contract interaction patterns

**User Benefits**:
- AI-powered vendor vetting for safer deposit placement
- Early warning system for potential event issues
- Automated risk scoring for advance funding decisions
- Reduced dispute rates through proactive monitoring

## 3. Core Features & User Flows

### 3.1 Vendor Onboarding & Contract Creation Flow
```
Vendor Journey:
1. Landing Page → Sign up with email/OTP (Dynamic embedded wallet)
2. Profile Setup → Business verification & portfolio upload
3. Risk Assessment → Zircuit analysis for advance funding eligibility
4. New Event Contract → Enter client details, event type, milestones
5. Contract Configuration → Set refund policies, milestone percentages
6. Generate Invite → Magic link + QR code for couple
7. Share Contract → Send via email/SMS to couple
```

**Technical Implementation**:
- Dynamic SDK creates embedded wallet seamlessly
- Zircuit risk scoring for vendor credibility
- EscrowFactory deploys new contract per event
- Smart contract stores milestone structure and refund policies

### 3.2 Couple Payment & Agreement Flow
```
Couple Journey:
1. Receive Invite → Click magic link (no wallet needed)
2. Review Contract → See milestone breakdown, refund policy
3. Payment Method → Choose card/Apple Pay (Fern integration)
4. Deposit Payment → Fiat converts to PYUSD, enters escrow
5. Agreement Active → Both parties see live milestone timeline
6. Yield Tracking → Real-time view of earnings on escrowed funds
```

**Technical Implementation**:
- Magic link authentication (Dynamic)
- Fern on-ramp: fiat → PYUSD → escrow contract
- PYUSD automatic staking for yield generation
- Real-time milestone dashboard with progress tracking

### 3.3 Milestone Release & Vendor Funding Flow
```
Milestone Completion:
1. Vendor Work → Complete milestone deliverable
2. Submit Proof → Upload photos/documents of completion
3. Couple Review → Approve or request changes
4. Release Funds → MultiSig approval triggers PYUSD transfer
5. Vendor Funding → Received funds immediately earn yield
6. Progress Update → Timeline shows completion and next milestone
```

**Advanced Feature - Vendor Advance Funding**:
```
1. Vendor Expense → Needs funds for event supplies/services
2. Request Advance → Specify amount and purpose
3. AI Risk Assessment → Zircuit evaluates request against escrow balance
4. Approval Process → Automated or requires couple consent based on risk
5. Advance Release → Funds provided with repayment terms
6. Milestone Integration → Repayment deducted from future releases
```

**Technical Implementation**:
- MultiSig signature collection for milestone approvals
- PYUSD transfer with yield activation on vendor wallet
- AI-powered advance funding risk assessment
- Automated repayment deduction from milestone releases

### 3.4 Guest Contribution & Registry Flow
```
Wedding Registry Integration:
1. Couple Setup → Enable guest contributions during contract creation
2. Registry Link → Share public link for wedding website/invitations
3. Guest Contribution → Guests contribute via Fern (fiat → PYUSD)
4. Escrow Addition → Contributions added to main escrow balance
5. Enhanced Budget → Additional funds enable upgrade options
6. Shared Celebration → All contributors see event progress
```

**Technical Implementation**:
- Public contribution interface (no wallet required)
- Fern handles guest payments and KYC for larger contributions
- PYUSD contributions automatically join main escrow
- Contributor dashboard showing event progress

### 3.5 Dispute Resolution & Mediation Flow
```
Dispute Process:
1. Issue Arises → Either party can flag a dispute
2. Automatic Pause → Funds locked pending resolution
3. Mediation Options → Choose mediator or platform arbitration
4. Evidence Submission → Both parties provide documentation
5. AI Analysis → Zircuit assists with dispute pattern recognition
6. Resolution → Mediator decides fund distribution
7. Execution → Smart contract automatically implements decision
```

**Technical Implementation**:
- Dispute flag pauses all fund releases
- Mediator role with special contract permissions
- Zircuit provides dispute risk scoring and pattern analysis
- Automated fund distribution based on mediator decision

### 3.6 Event Completion & Final Settlement
```
Event Conclusion:
1. Final Milestone → Last payment released to vendor
2. Yield Distribution → All accumulated yield goes to couple
3. Final Statement → Complete financial summary for both parties
4. Archive Contract → Event marked complete, escrow destroyed
5. Review System → Both parties rate experience
6. Export Records → PDF statements for taxes/records
```

**Technical Implementation**:
- Final PYUSD release to vendor wallet
- Yield accumulation transferred to couple's personal wallet
- Contract cleanup and gas optimization
- Review data stored for vendor reputation system

## 4. Event-Specific Templates & Features

### 4.1 Wedding Template
**Essential Expenses (40-60% of budget)**:
- Venue booking and catering (milestone: contract signed)
- Photography/videography (milestones: engagement shoot, wedding day)
- Wedding attire and beauty (milestone: final fitting)

**Secondary Expenses (20-30% of budget)**:
- Flowers and decor (milestone: design approval)
- Music and entertainment (milestone: playlist finalized)
- Wedding coordinator (milestone: timeline confirmed)

**Variable Expenses (10-20% of budget)**:
- Stationery and invitations
- Transportation and accommodations
- Wedding party gifts

**Hidden Costs Buffer (10-15% via AI prediction)**:
- Marriage license and officiant fees
- Tips and gratuities
- Taxes and service fees
- Emergency contingencies

### 4.2 Corporate Event Template
**Core Services**:
- Venue and AV equipment
- Catering and beverage service
- Event coordination and staff

**Marketing & Branding**:
- Photography and videography
- Branded materials and signage
- Registration and check-in systems

### 4.3 Private Party Template
**Essential Elements**:
- Venue rental
- Food and beverage
- Entertainment

**Enhancement Options**:
- Decorations and theming
- Photography
- Special services

## 5. Technical Architecture

### 5.1 Smart Contract System

**EventEscrowFactory.sol**:
```solidity
contract EventEscrowFactory {
    function createEventEscrow(
        address couple,
        address vendor,
        EventMilestone[] milestones,
        RefundPolicy refundTerms,
        address mediator
    ) external returns (address escrowContract);
    
    function getEventEscrows(address user) external view returns (address[]);
    function updateVendorRating(address vendor, uint8 rating) external;
}
```

**EventEscrow.sol**:
```solidity
contract EventEscrow {
    struct EventMilestone {
        uint256 amount;
        string description;
        uint256 dueDate;
        bool completed;
        mapping(address => bool) signatures;
    }
    
    struct AdvanceFunding {
        uint256 amount;
        uint256 repaymentRate;
        bool approved;
        uint256 remainingBalance;
    }
    
    function depositFunds() external payable;
    function releaseMilestone(uint256 milestoneId) external requiresMultiSig;
    function requestAdvanceFunding(uint256 amount, string purpose) external;
    function approveAdvanceFunding(uint256 requestId) external;
    function flagDispute() external;
    function resolveDispute(uint256 coupleAmount, uint256 vendorAmount) external onlyMediator;
}
```

**YieldManager.sol**:
```solidity
contract YieldManager {
    function stakeEventFunds(address escrowContract) external;
    function distributeYield(address recipient) external;
    function calculateCurrentYield(address escrowContract) external view returns (uint256);
    function getYieldHistory(address user) external view returns (YieldRecord[]);
}
```

**ContributionRegistry.sol**:
```solidity
contract ContributionRegistry {
    function addContribution(
        address escrowContract,
        address contributor,
        uint256 amount,
        string memory message
    ) external;
    
    function getContributors(address escrowContract) external view returns (Contributor[]);
    function enablePublicContributions(address escrowContract) external;
}
```

### 5.2 Frontend Architecture

**Core Pages**:
- **Landing**: Vendor sign-up and couple payment links
- **Vendor Dashboard**: Event management, milestone tracking, advance funding
- **Couple Dashboard**: Contract review, milestone approval, yield tracking
- **Event Timeline**: Shared progress view for both parties
- **Contribution Page**: Public registry for guest contributions
- **Dispute Center**: Mediation interface and resolution tracking

**Key Components**:
```typescript
// Dynamic Integration
<WalletProvider embedded={true}>
  <VendorOnboarding />
  <CouplePayment />
</WalletProvider>

// PYUSD Operations
<EventEscrowManager>
  <DepositFlow />
  <MilestoneRelease />
  <YieldTracker />
</EventEscrowManager>

// Fern Integration
<PaymentGateway>
  <FiatToUSDC />
  <GuestContributions />
  <VendorPayouts />
</PaymentGateway>

// Zircuit Monitoring
<RiskAssessment>
  <VendorScoring />
  <DisputePrediction />
  <AdvanceFundingApproval />
</RiskAssessment>
```

## 6. User Experience Specifications

### 6.1 Vendor Experience

**Dashboard Features**:
- Active events with milestone progress
- Advance funding requests and approvals
- Yield earnings from completed milestones
- Client communication and deliverable uploads
- Risk score and advance funding eligibility

**Key Workflows**:
- Contract creation with milestone templates
- Proof of completion submission
- Advance funding request with AI risk assessment
- Dispute initiation and evidence submission

### 6.2 Couple Experience

**Dashboard Features**:
- Event timeline with upcoming milestones
- Yield earnings on escrowed funds
- Guest contribution tracking
- Vendor communication and deliverable review
- Payment history and tax documentation

**Key Workflows**:
- Contract review and deposit payment via fiat
- Milestone approval with proof verification
- Guest registry management and contribution sharing
- Dispute escalation and mediation access

### 6.3 Guest Experience

**Contribution Interface**:
- Event details and couple information
- Contribution amount selection with suggested tiers
- Payment via credit card or Apple Pay (Fern)
- Personal message attachment
- Contribution confirmation and event updates

## 7. AI & Risk Management Features

### 7.1 Vendor Risk Assessment (Zircuit)
**Scoring Factors**:
- Event completion history and ratings
- Financial stability and business verification
- Communication patterns and responsiveness
- Dispute history and resolution outcomes

**Advance Funding Eligibility**:
- Risk score thresholds for automatic approval
- Escrow balance vs. advance amount ratios
- Event type and vendor specialization matching
- Historical performance in similar events

### 7.2 Dispute Prediction & Prevention
**Early Warning Indicators**:
- Delayed milestone completions
- Unusual communication patterns
- Payment timing anomalies
- Vendor behavior pattern deviations

**Proactive Interventions**:
- Automated check-ins for at-risk contracts
- Mediation suggestions before formal disputes
- Additional documentation requirements
- Enhanced monitoring for high-risk situations

### 7.3 Budget Optimization AI
**Cost Prediction Features**:
- Hidden cost identification and budgeting
- Vendor price comparison and recommendations
- Seasonal pricing optimization
- Contingency fund size recommendations

## 8. Development Phases

### Phase 1: Core Escrow (Week 1-2)
- Dynamic wallet integration and embedded accounts
- Basic PYUSD escrow contract deployment
- Simple milestone creation and release workflow
- Fern fiat on-ramp integration

### Phase 2: Event Features (Week 3-4)
- Event-specific templates (wedding, corporate, party)
- Guest contribution system
- Yield generation and distribution
- Basic vendor advance funding

### Phase 3: AI & Risk Management (Week 5-6)
- Zircuit risk assessment integration
- Dispute resolution system
- AI-powered advance funding approvals
- Advanced security monitoring

### Phase 4: Polish & Demo (Week 7-8)
- UI/UX refinement and mobile responsiveness
- Comprehensive testing and bug fixes
- Demo data and presentation preparation
- Documentation and user guides

## 9. Hackathon Demo Flow

### 9.1 Live Demonstration Scenario
**Event**: "Alex & Kirsten's Wedding"
**Vendor**: "Blossom Florals" (wedding florist)
**Contract Value**: $3,500 with 3 milestones

**Demo Script**:
1. **Vendor Creates Contract** (Dynamic embedded wallet)
   - Set milestones: Design approval ($500), Final arrangements ($2,000), Day-of delivery ($1,000)
   - Configure refund policy and generate magic link

2. **Couple Pays Deposit** (Fern fiat integration)
   - Click magic link, review terms
   - Pay $3,500 via credit card → converts to PYUSD in escrow
   - Yield generation begins immediately

3. **Milestone Progression** (PYUSD operations)
   - Vendor submits design mockups
   - Couple approves → $500 released to vendor
   - Vendor requests $800 advance for flower orders

4. **AI Risk Assessment** (Zircuit integration)
   - System analyzes advance request against escrow balance
   - Approves advance based on vendor history and risk score
   - Advance funded, repayment scheduled from next milestone

5. **Guest Contributions** (Fern + PYUSD)
   - Wedding registry link shared
   - Guest contributes $200 → added to escrow balance
   - Couple sees increased budget for upgrades

6. **Final Settlement** (Complete integration)
   - Event completed, final milestone released
   - Accumulated yield ($45) distributed to couple
   - Both parties receive completion certificates

### 9.2 Technical Achievements Demonstrated
- ✅ All four sponsor technologies integrated meaningfully
- ✅ Real on-chain transactions with live yield generation
- ✅ AI-powered risk assessment in action
- ✅ Seamless fiat-to-crypto user experience
- ✅ Complete escrow lifecycle from creation to completion
- ✅ Advanced features (advance funding, guest contributions)

## 10. Business Model & Value Proposition

### 10.1 Revenue Streams
- **Platform fee**: 1-2% of escrow value
- **Yield sharing**: 10-20% of generated yield
- **Premium features**: Advanced AI insights, priority support
- **Vendor subscriptions**: Monthly plans for high-volume vendors

### 10.2 Market Opportunity
- **Wedding industry**: $300B+ globally, $50B+ in US
- **Corporate events**: $1.1T+ global business events market
- **Pain point severity**: 60%+ of event disputes related to vendor payments
- **Technology adoption**: Growing crypto acceptance in service industries

### 10.3 Competitive Advantages
- **Yield generation**: Unique value proposition reducing effective escrow costs
- **AI risk management**: Advanced dispute prevention and vendor assessment
- **Seamless UX**: Non-crypto users can participate without technical barriers
- **Comprehensive solution**: End-to-end event payment management

## 11. Risk Mitigation & Security

### 11.1 Smart Contract Security
- **Multi-signature requirements** for all fund releases
- **Time-locked operations** for large transactions
- **Emergency pause functionality** for critical issues
- **Comprehensive testing** and security audits

### 11.2 Financial Risk Management
- **Yield protocol whitelisting** to prevent asset loss
- **Insurance integration** for high-value events
- **Dispute mediation reserves** for resolution costs
- **Regulatory compliance** through PYUSD and Fern

### 11.3 User Protection
- **KYC verification** for large transactions
- **Fraud monitoring** through Zircuit integration
- **Dispute resolution guarantees** with mediator network
- **Educational resources** for safe platform usage

## 12. Success Metrics & KPIs

### 12.1 Hackathon Success Criteria
- **Technical Integration**: All sponsor technologies working together
- **User Experience**: Complete user journey without friction
- **Business Value**: Clear cost savings and risk reduction demonstration
- **Innovation Factor**: Novel application of DeFi concepts to events industry

### 12.2 Post-Hackathon Metrics
- **Adoption Rate**: Events processed per month
- **Financial Impact**: Total value locked and yield generated
- **User Satisfaction**: Net Promoter Score and retention rates
- **Market Penetration**: Vendor sign-ups and geographic expansion

FairHold represents the future of event planning payments - combining the security of smart contracts, the profitability of DeFi yield generation, and the accessibility of traditional payment methods to create a superior experience for both event planners and their clients.
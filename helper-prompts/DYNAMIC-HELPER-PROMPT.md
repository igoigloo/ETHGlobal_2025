I'm building FairHold, a smart escrow platform on scaffold-eth-2 that needs seamless onboarding for non-crypto users alongside support for crypto-native users. The platform requires embedded smart accounts for gasless transactions and magic link sharing.

Core Requirements:
- Embedded smart account creation via email/OTP (no wallet setup required)
- Magic link generation for contract invitations
- Gasless transaction infrastructure (paymaster integration)
- Multi-wallet support for crypto-native users who want to connect existing wallets
- Account linking between embedded accounts and external wallets
- Session persistence across page reloads

Key User Flows:
1. Vendor creates account via email/OTP → Embedded smart account created automatically
2. Vendor generates magic link for client → Client accesses without wallet setup
3. Client signs in via email/OTP → Immediate access to escrow functionality
4. Optional: Advanced users can connect existing wallets to embedded accounts
5. All transactions are gasless for both parties

Technical Specifications:
- Scaffold-eth-2 integration with existing infrastructure
- React components for email/OTP authentication
- Magic link generation and validation system
- Paymaster configuration for gasless operations
- Account abstraction for seamless UX
- Integration hooks for PYUSD operations (coming in next phase)

Specific Deliverables:
1. Dynamic SDK setup for embedded smart accounts
2. Email/OTP authentication components
3. Magic link generation and sharing system
4. Gasless transaction infrastructure
5. Account management dashboard (embedded + external wallets)
6. Session management and persistence
7. Integration points for future escrow contract interactions

Critical Success Criteria:
- Users can create accounts and access platform without any crypto knowledge
- Magic links work seamlessly for contract sharing
- All transactions are gasless from user perspective
- Smooth onboarding flow takes <2 minutes
- Foundation ready for PYUSD and smart contract integration

Focus on creating a web2-like experience that completely abstracts away blockchain complexity while maintaining web3 security and functionality.
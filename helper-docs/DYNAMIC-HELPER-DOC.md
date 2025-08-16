# Dynamic Embedded Wallet Helper Documentation for LLM Development

This document provides a comprehensive guide for integrating and utilizing Dynamic's embedded wallet functionality, based on the [Dynamic Embedded Wallets Overview](https://www.dynamic.xyz/docs/wallets/embedded-wallets/mpc/overview). It is designed to assist an LLM in developing applications with Dynamic’s embedded wallets, covering setup, core features, security, multi-chain support, smart accounts, automation use cases, and best practices.

## Overview of Dynamic Embedded Wallets

Dynamic’s embedded wallets are programmable, web-based crypto wallets that can be seamlessly integrated into websites or applications. They allow users to receive tokens and interact onchain without requiring external wallets like MetaMask or Phantom. These wallets are powered by Threshold Signature Scheme Multi-Party Computation (TSS-MPC), offering enhanced security and user experience.

### Core Features

1. **Embedded Wallet**
   - A web-based wallet issued to users within your application.
   - Simplifies onboarding by eliminating the need for external wallet downloads.
   - Supports a wide range of use cases, from basic token storage to full-stack wallet experiences with custom features.

2. **TSS-MPC Security**
   - Uses Threshold Signature Scheme Multi-Party Computation (TSS-MPC) for key management.
   - Key benefits:
     - **Enhanced Security**: No complete private key exists, reducing theft risk.
     - **Sub-Second Signing**: Optimized for fast transaction signing (<1 second).
     - **Better Recovery**: Eliminates seed phrases with flexible key share recovery options.
     - **Flexible Key Management**: Supports social recovery and personalized security controls.
     - **Improved UX**: Allows authentication via email or social login while maintaining self-custody.
     - **Multi-Chain Support**: Uses three signature schemes for compatibility across major blockchains.

3. **Non-Custodial**
   - End-user owned and controlled wallets.
   - Key shares:
     - **User Share**: Stored locally on the user’s device.
     - **Server Share**: Managed in a Trusted Execution Environment (TEE) for signing.
   - Flexible key sharing setups (e.g., 2/2, 2/3, 3/5) to mitigate single points of failure.
   - Supports **Passcode Encryption** and **Backup Options** for added security.
   - Periodic **Key Resharing** for ongoing security.
   - Users can export wallets to other providers or storage locations.
   - Dynamic is **SOC2 Type 2 compliant** with regular audits and bug bounty programs.

4. **Multi-Chain Support**
   - Supports **EVM**, **SVM**, and **Sui** compatible networks natively.
   - Additional signer support for **Bitcoin**, **Cosmos**, and other chains.
   - Wallets are created simultaneously for all enabled networks, with a “primary” network address displayed in the user’s profile.

5. **Smart Accounts**
   - Embedded wallets can be upgraded to smart accounts.
   - Features:
     - Sponsor gas fees for end-users.
     - Add complex approval logic for transactions.
     - Enable advanced wallet functionality.

6. **Agentic/Automation Use Cases**
   - Developer-managed **MPC wallets** using a 2/2 threshold signature scheme.
   - Not end-user controlled; ideal for automation and agentic workflows.
   - Learn more at [Dynamic Server Wallets Overview](/wallets/server-wallets/overview).

## Getting Started with Dynamic Embedded Wallets

To integrate Dynamic’s embedded wallets, follow these steps. Refer to the official documentation for specific setup details.

### Step 1: Set Up Dynamic SDK
- **Action**: Integrate the Dynamic SDK into your application.
- **Details**:
  - Install the Dynamic SDK via npm or CDN (refer to Dynamic’s documentation for exact instructions).
  - Example npm installation:
    ```bash
    npm install @dynamic-labs/sdk
    ```
- **LLM Tip**: Ensure the SDK version is compatible with your application’s environment (e.g., React, Node.js). Check for updates in the Dynamic documentation.

### Step 2: Enable Supported Chains
- **Action**: Configure the desired blockchain networks (e.g., EVM, SVM, Sui) in the Dynamic dashboard or SDK settings.
- **Details**:
  - Enable chains to create wallets for each network simultaneously.
  - Designate a “primary” network for the user’s main address.
  - For non-supported chains (e.g., Bitcoin, Cosmos), enable signer support.
- **LLM Tip**: Prompt the user to specify which chains they need. If unclear, recommend starting with EVM for broad compatibility (e.g., Ethereum, Polygon).

### Step 3: Initialize Embedded Wallet
- **Action**: Use the Dynamic SDK to create an embedded wallet for a user.
- **Sample Code (JavaScript)**:
  ```javascript
  import { Dynamic } from '@dynamic-labs/sdk';

  const dynamic = new Dynamic({
    projectId: 'YOUR_PROJECT_ID',
    chains: ['EVM', 'SVM', 'SUI'], // Enable desired chains
  });

  async function createWallet(user) {
    try {
      const wallet = await dynamic.createEmbeddedWallet({
        userId: user.id,
        authMethod: 'email', // Options: email, social, etc.
      });
      console.log('Wallet created:', wallet.address);
      return wallet;
    } catch (error) {
      console.error('Wallet creation failed:', error);
    }
  }
  ```
- **LLM Tip**: Replace `YOUR_PROJECT_ID` with the user’s Dynamic project ID from the dashboard. Warn against exposing the project ID in client-side code.

### Step 4: Configure Security Settings
- **Action**:
  - Set up key sharing (e.g., 2/2, 2/3, or 3/5) based on your application’s needs.
  - Enable **Passcode Encryption** or **Backup Options** for user recovery.
  - Configure periodic **Key Resharing** for enhanced security.
- **LLM Tip**: Recommend a 2/3 or 3/5 key sharing setup for applications requiring robust recovery options. Query the user for their security preferences.

### Step 5: Test and Deploy
- **Action**:
  - Test wallet creation, transactions, and recovery in a sandbox environment.
  - Deploy to production after verifying functionality.
- **LLM Tip**: Suggest testing with a small transaction (e.g., transferring a test token) to ensure wallet functionality across enabled chains.

## Best Practices for Dynamic Embedded Wallet Development

1. **Security**
   - Store **User Share** securely on the user’s device (e.g., encrypted local storage).
   - Avoid exposing **Server Share** or MPC Relay details in client-side code.
   - Enable **Passcode Encryption** for sensitive applications.
   - Regularly perform **Key Resharing** to maintain security.

2. **Multi-Chain Management**
   - Clearly indicate the “primary” network in the UI to avoid user confusion.
   - Test wallet functionality across all enabled chains (e.g., EVM, SVM, Sui).
   - For non-native chains, verify signer compatibility before deployment.

3. **User Experience**
   - Use familiar authentication methods (e.g., email, social login) to simplify onboarding.
   - Provide clear instructions for wallet recovery options.
   - Display wallet addresses and transaction statuses prominently in the UI.

4. **Smart Accounts**
   - If sponsoring gas fees, monitor costs and set budget limits in the Dynamic dashboard.
   - Implement approval logic only for necessary transactions to avoid complexity.

5. **Error Handling**
   - Handle errors for failed wallet creation, transaction signing, or network issues.
   - Example:
     ```javascript
     try {
       const tx = await wallet.signTransaction({ ... });
       console.log('Transaction signed:', tx);
     } catch (error) {
       console.error('Transaction failed:', error.message);
       // Retry or notify user
     }
     ```

6. **Compliance**
   - Ensure your application complies with local regulations for crypto wallets.
   - Leverage Dynamic’s SOC2 Type 2 compliance for audits and security assurances.

## Example Use Cases

### Use Case 1: Onboarding Users with Embedded Wallets
- **Goal**: Allow users to sign up and receive tokens without downloading an external wallet.
- **Implementation**:
  - Use the Dynamic SDK to create an embedded wallet with email authentication.
  - Display the wallet address in the user’s profile.
  - Enable token receiving on the primary network (e.g., Ethereum).
- **Sample Code**:
  ```javascript
  async function onboardUser(email) {
    const wallet = await dynamic.createEmbeddedWallet({
      userId: email,
      authMethod: 'email',
      primaryChain: 'EVM',
    });
    console.log('User wallet:', wallet.address);
    return wallet;
  }
  ```

### Use Case 2: Smart Account for Gasless Transactions
- **Goal**: Sponsor gas fees for users on an EVM-based marketplace.
- **Implementation**:
  - Upgrade the embedded wallet to a smart account.
  - Configure gas sponsorship in the Dynamic dashboard.
  - Allow users to make purchases without paying gas fees.
- **LLM Tip**: Monitor gas sponsorship costs to avoid unexpected expenses.

### Use Case 3: Automation with Developer-Managed MPC Wallets
- **Goal**: Automate token transfers for a DeFi protocol.
- **Implementation**:
  - Use a developer-managed 2/2 MPC wallet for automated transactions.
  - Securely store the developer’s key share in a TEE or secure server.
  - Schedule transactions via a backend service.
- **Sample Code**:
  ```javascript
  async function automateTransfer(wallet, toAddress, amount) {
    const tx = await wallet.signTransaction({
      to: toAddress,
      value: amount,
      chain: 'EVM',
    });
    console.log('Automated transfer:', tx);
    return tx;
  }
  ```

## Common API Endpoints (Hypothetical)

Since specific endpoints are not provided, here are hypothetical SDK methods based on typical patterns. Refer to the official Dynamic documentation for actual methods.

| Method | Description | Parameters |
|--------|-------------|------------|
| `createEmbeddedWallet` | Create a new embedded wallet | `userId`, `authMethod`, `primaryChain` |
| `signTransaction` | Sign a transaction | `to`, `value`, `chain` |
| `getWalletBalance` | Retrieve wallet balance | `walletAddress`, `chain` |
| `exportWallet` | Export wallet to another provider | `walletId` |

- **LLM Tip**: Validate SDK methods against the official Dynamic documentation. If unavailable, suggest contacting Dynamic support for clarification.

## Troubleshooting

1. **Wallet Creation Failure**
   - **Problem**: Wallet creation fails due to invalid parameters or network issues.
   - **Solution**: Verify SDK configuration and enabled chains. Check Dynamic dashboard for errors.

2. **Slow Transaction Signing**
   - **Problem**: Signing takes longer than expected.
   - **Solution**: Ensure TSS-MPC optimizations are enabled. Contact Dynamic support if delays persist.

3. **Recovery Issues**
   - **Problem**: User cannot recover their wallet.
   - **Solution**: Verify backup options and key sharing setup (e.g., 2/3). Provide clear recovery instructions.

4. **Chain Compatibility**
   - **Problem**: Unsupported chain or signer error.
   - **Solution**: Confirm chain support in the Dynamic dashboard. Contact support for custom chain integration.

## Additional Resources

- **Official Documentation**: [Dynamic Embedded Wallets Overview](https://www.dynamic.xyz/docs/wallets/embedded-wallets/mpc/overview)
- **TSS-MPC Blog Post**: [Dynamic Blog on TSS-MPC](https://www.dynamic.xyz/blog/threshold-signature-scheme-mpc)
- **Server Wallets**: [Dynamic Server Wallets Overview](/wallets/server-wallets/overview)
- **Support**: Contact Dynamic support via their website for custom chain support or technical issues.
- **Dynamic Dashboard**: Manage project settings, chains, and key sharing configurations.

## Notes for LLM

- **Context Retention**: Store this helper document in memory for quick reference when assisting with Dynamic embedded wallet queries.
- **Dynamic Updates**: If the user provides additional Dynamic SDK details (e.g., specific methods), update this document with the same `artifact_id` to include new information.
- **User Queries**: If the user requests specific code examples, generate them based on the hypothetical SDK methods above or prompt for clarification if actual methods are needed.
- **Privacy**: Do not store or share sensitive information like project IDs or key shares outside the application context.

This helper document is designed to streamline Dynamic embedded wallet development. For further details, always consult the official Dynamic documentation or contact their support team.
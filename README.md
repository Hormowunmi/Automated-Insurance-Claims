# Automated Insurance Claims Contract

A parametric insurance smart contract built on the Stacks blockchain that automatically processes claims based on predefined weather conditions using external oracle data.

## Overview

This contract enables decentralized insurance for weather-related risks by automatically triggering payouts when specific weather conditions are met, eliminating the need for manual claim processing and reducing settlement times.

## Features

### 🌦️ Parametric Insurance
- Automatic claim processing based on objective weather data
- No manual claim assessment required
- Instant payouts when conditions are met

### 🏛️ Multiple Risk Profiles
- **Agricultural Drought Insurance**: Protection against extended dry periods
- **Flood Insurance**: Coverage for excessive rainfall events  
- **Hurricane Insurance**: Protection against extreme wind events
- **Frost Insurance**: Coverage for temperature-based crop damage

### 🔮 Oracle Integration
- External weather data feeds
- Configurable data sources
- Multi-oracle support for data redundancy

### 💰 Treasury Management
- Automated premium collection
- Claim payout processing
- Balance tracking and validation

## Getting Started

### Prerequisites
- [Clarinet](https://github.com/hirosystems/clarinet) for local development
- Stacks wallet for testnet/mainnet deployment

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd Automated-Insurance-Claim
```

2. Check contract syntax:
```bash
clarinet check
```

3. Run tests:
```bash
clarinet test
```

## Usage

### For Policyholders

#### 1. Create a Policy
```clarity
(contract-call? .automated-claim-contract create-policy
  u1        ;; risk-profile-id (1=drought, 2=flood, 3=hurricane, 4=frost)
  u100000000 ;; coverage-amount (1000 STX)
  u4320     ;; duration-blocks (~30 days)
  true      ;; auto-renew
  "Farm Location XYZ" ;; location
)
```

#### 2. Add Claim Conditions
```clarity
(contract-call? .automated-claim-contract add-policy-condition
  u1        ;; policy-id
  u1        ;; weather-type (WEATHER-RAINFALL)
  u2        ;; operator (OPERATOR-LESS-THAN)
  u50       ;; threshold-value (50mm rainfall)
  u8000     ;; payout-percentage (80% of coverage)
  "oracle-weather-001" ;; oracle-id
)
```

#### 3. Submit Claims
```clarity
(contract-call? .automated-claim-contract submit-claim u1) ;; policy-id
```

### For Oracle Operators

#### 1. Register as Oracle
```clarity
(contract-call? .automated-claim-contract register-oracle
  "oracle-weather-001"     ;; oracle-id
  "WeatherData Provider"   ;; oracle-name
  u1                       ;; oracle-type
)
```

#### 2. Submit Weather Data
```clarity
(contract-call? .automated-claim-contract submit-oracle-data
  "oracle-weather-001"  ;; oracle-id
  u1                   ;; weather-type (WEATHER-RAINFALL)
  "Location XYZ"       ;; location
  u45                  ;; value (45mm rainfall)
  u1640995200         ;; timestamp
)
```

## Contract Architecture

### Data Structures

#### Risk Profiles
- `profile-id`: Unique identifier
- `base-premium-rate`: Base premium as basis points
- `coverage-multiplier`: Coverage calculation factor
- `risk-factor`: Additional risk premium
- `min-coverage`/`max-coverage`: Coverage limits

#### Policies  
- `policy-id`: Unique identifier
- `policyholder`: Owner principal
- `coverage-amount`: Insurance coverage in µSTX
- `premium-amount`: Paid premium in µSTX
- `start-block`/`end-block`: Policy validity period
- `policy-status`: Current status (active/expired/canceled/claimed)

#### Claims
- `claim-id`: Unique identifier  
- `policy-id`: Associated policy
- `claim-amount`: Payout amount in µSTX
- `claim-status`: Processing status
- `weather-event-value`: Triggering weather value

### Error Codes

| Code | Error | Description |
|------|-------|-------------|
| u1 | ERR-NOT-AUTHORIZED | Caller not authorized for action |
| u2 | ERR-POLICY-NOT-FOUND | Policy ID doesn't exist |
| u3 | ERR-POLICY-EXPIRED | Policy is past expiration |
| u4 | ERR-POLICY-NOT-ACTIVE | Policy is not in active status |
| u5 | ERR-INSUFFICIENT-PAYMENT | Premium payment too low |
| u6 | ERR-INVALID-RISK-PROFILE | Risk profile doesn't exist |
| u7 | ERR-INVALID-COVERAGE-AMOUNT | Coverage outside allowed range |
| u8 | ERR-ALREADY-CLAIMED | Policy already has active claim |
| u9 | ERR-CLAIM-NOT-FOUND | Claim ID doesn't exist |
| u10 | ERR-INVALID-ORACLE-DATA | Oracle data format invalid |
| u11 | ERR-CLAIM-CONDITION-NOT-MET | Weather condition not triggered |
| u12 | ERR-ORACLE-NOT-REGISTERED | Oracle not found in registry |

## Weather Event Types

| Type | Constant | Description |
|------|----------|-------------|
| u1 | WEATHER-RAINFALL | Precipitation measurements |
| u2 | WEATHER-TEMPERATURE | Temperature readings |
| u3 | WEATHER-WIND-SPEED | Wind speed measurements |
| u4 | WEATHER-HUMIDITY | Humidity percentage |
| u5 | WEATHER-HURRICANE | Hurricane category |
| u6 | WEATHER-FLOOD | Flood severity level |
| u7 | WEATHER-DROUGHT | Drought index |

## Condition Operators

| Operator | Constant | Description |
|----------|----------|-------------|
| u1 | OPERATOR-GREATER-THAN | Value > threshold |
| u2 | OPERATOR-LESS-THAN | Value < threshold |
| u3 | OPERATOR-EQUAL-TO | Value = threshold |
| u4 | OPERATOR-GREATER-THAN-OR-EQUAL | Value >= threshold |
| u5 | OPERATOR-LESS-THAN-OR-EQUAL | Value <= threshold |

## Testing

The contract includes comprehensive tests covering:
- Policy creation and management
- Premium calculations
- Oracle data submission
- Claim processing
- Error conditions

Run tests with:
```bash
clarinet test
```

## Security Considerations

- **Oracle Trust**: Ensure oracle data sources are reliable and tamper-resistant
- **Premium Adequacy**: Risk profiles should be calibrated with historical data
- **Treasury Management**: Monitor treasury balance to ensure claim payment capacity
- **Access Control**: Only authorized principals can perform administrative functions

## Deployment

### Testnet Deployment
```bash
clarinet deploy --testnet
```

### Mainnet Deployment
```bash
clarinet deploy --mainnet
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support:
- Create an issue in the GitHub repository
- Join our Discord community
- Check the documentation wiki

## Roadmap

- [ ] Multi-condition policies (AND/OR logic)
- [ ] Dynamic premium adjustments
- [ ] Reinsurance pool integration
- [ ] Cross-chain oracle support
- [ ] Mobile DApp interface
- [ ] Historical weather data analysis
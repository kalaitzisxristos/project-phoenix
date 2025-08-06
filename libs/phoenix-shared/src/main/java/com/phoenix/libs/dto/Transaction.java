package com.phoenix.libs.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * A simple DTO representing a financial transaction.
 * This class will be shared across multiple microservices.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Transaction {
    private long step;
    private String type;
    private BigDecimal amount;
    private String nameOrig;
    private BigDecimal oldBalanceOrg;
    private BigDecimal newBalanceOrig;
    private String nameDest;
    private BigDecimal oldBalanceDest;
    private BigDecimal newBalanceDest;
}
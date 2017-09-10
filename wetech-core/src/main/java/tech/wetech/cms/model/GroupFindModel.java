package tech.wetech.cms.model;

import java.math.BigInteger;

/**
 * Created by cjbi on 2017/9/9.
 */
public class GroupFindModel extends Group {

    /**
     * 用户数量
     */
    private BigInteger userCount;

    public BigInteger getUserCount() {
        return userCount;
    }

    public void setUserCount(BigInteger userCount) {
        this.userCount = userCount;
    }
}

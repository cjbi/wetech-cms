package tech.wetech.cms.model;

import java.math.BigInteger;

/**
 * Created by cjbi on 2017/9/10.
 */
public class RoleFindModel  {

    /**
     * 角色id
     */
    private int id;
    /**
     * 角色的名称，中文
     */
    private String name;

    /**
     * 用户类型
     */
    private String roleType;

    /**
     * 用户数量
     */
    private BigInteger userCount;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRoleType() {
        return roleType;
    }

    public void setRoleType(String roleType) {
        this.roleType = roleType;
    }

    public BigInteger getUserCount() {
        return userCount;
    }

    public void setUserCount(BigInteger userCount) {
        this.userCount = userCount;
    }
}

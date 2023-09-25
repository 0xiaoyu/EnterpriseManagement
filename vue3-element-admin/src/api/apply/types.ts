export interface Apply{
    id?:Number;

    /**
     * 申请人"
     */
    userId?:Number;

    /**
     * 开始时间
     */
    startTime?: Date;

    /**
     * 结束时间
     */
    endTime?: Date;

    /**
     * 描述
     */
    detail?:String;
    /**
     * 申请类型
     */
    type?:Number;

    /**
     * 审批人
     */
    approvedUserId?:Number;

}

export interface ApplyQuery extends PageQuery{
    /**
     * 审批人
     */
    approvedUser?:Number;
    /**
     * 状态
     */
    status?: Number;
    /**
     * 申请类型
     */
    type?:Number;
}

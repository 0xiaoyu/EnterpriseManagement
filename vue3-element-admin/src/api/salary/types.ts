export interface SalaryPageQuery extends PageQuery {
  userId?: number;
  deptId?: number;
  month?: string;
}

export interface Salary {
  /**
   * id
   */
  id?: number;
  /**
   * 人员id
   */
  userId?: number;
  /**
   * 时间
   */
  month?: string;
  /**
   * 薪资
   */
  salary?: number;
  /**
   * 状态,0未发，1统计中，2发送
   */
  status?: number;
  /**
   * 人员名字
   */
  name?: string;
  /**
   * 手机号
   */
  mobile?: string;
}


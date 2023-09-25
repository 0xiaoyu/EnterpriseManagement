
export interface PageWorkExcParam extends PageQuery{
  /**
   * 姓名
   */
  name?: String;
  /**
   * 部门id
   */
  dept?: number;
  /**
   * 	开始时间
   */
  startTime?: Date;
  /**
   * 结束时间
   */
  endTime?: Date;
  /**
   * 类型
   */
  type?: String;
}

export interface WorkExcLog {
  /**
   * id
   */
  id?: number;
  /**
   * 用户id
   */
  userId?: number;
  /**
   * 时间
   */
  time?: Date;
  /**
   * 类型
   */
  type?: String;
  /**
   * 人员名称
   */
  name?: String;
  /**
   * 手机号
   */
  mobile?: String;
  /**
   * 部门名称
   */
  deptName?: String;
}

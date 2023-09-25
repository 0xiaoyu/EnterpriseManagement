export interface NoticeVo {
  /**
   * 通知id
   */
  id?: number;
  /**
   * 通知人名字
   */
  name?: String;

  /**
   * 通知内容
   */
  msg?: String;

  /**
   * 标题
   */
  title?: String;

  /**
   * 是否已读
   */
  isRead?: Boolean;

  /**
   * 通知类型
   */
  type?: String;
}

export interface noticeForm{
  /**
   * 接收者id
   */
  receiveId?: String
  /**
   * 部门id
   */
  deptId?: String,
  /**
   * 标题
   */
  title?: String,
  /**
   * 内容
   */
  content?: String,
  /**
   * 类型
   */
  type?: String
}

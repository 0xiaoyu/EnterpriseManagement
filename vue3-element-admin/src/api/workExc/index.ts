import request from "@/utils/request";
import {PageWorkExcParam, WorkExcLog} from "@/api/workExc/types";

const baseUrl = "/work-exc"

/**
 * 分页查询
 * @param data
 */
export function pageWorkExc(data: PageWorkExcParam) {
  return request({
    url: `${baseUrl}`,
    method: 'post',
    data
  })
}

/**
 * 新增异常类型
 * @param data
 */
export function addWorkExc(data: WorkExcLog) {
  return request({
    url: `${baseUrl}`,
    method: 'post',
    data
  })
}

export function deleteWorkExc(id: number) {
  return request({
    url: `${baseUrl}/${id}`,
    method: 'delete'
  })
}

export function updateWorkExc(data: WorkExcLog) {
  return request({
    url: `${baseUrl}`,
    method: 'patch',
    data
  })
}

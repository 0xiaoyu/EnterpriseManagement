import request from "@/utils/request";
import {PageWorkExcParam, WorkExcLog} from "@/api/workExc/types";

const baseUrl = "/work-exc"

/**
 * 分页查询
 * @param params
 */
export function pageWorkExc(params: PageWorkExcParam) {
  return request({
    url: `${baseUrl}`,
    method: 'get',
    params
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

export function exportWorkExc(data:PageWorkExcParam){
  return request({
    url: `${baseUrl}/_export`,
    method: 'post',
    data
  })
}

export function getAllWorkExcType(){
  return request({
    url: `${baseUrl}/typeEnum`,
    method: 'get'
  })
}

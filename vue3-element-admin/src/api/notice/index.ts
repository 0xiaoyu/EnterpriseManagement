import request from "@/utils/request";

const baseUrl = "/api/v1/notice"

export const getUserNoReadCount = () => {
  return request({
    url: `${baseUrl}/count/noRead`,
    method: "GET",
  })
}

export function listNoRead(){
  return request({
    url: `${baseUrl}/list/noRead`,
    method: "GET",
  })
}

export function listRead(params){
  return request({
    url: `${baseUrl}/list`,
    method: "GET",
    params
  })
}

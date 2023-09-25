import request from "@/utils/request";
import {Apply} from "@/api/apply/types";

const baseUrl = "/api/v1/apply"

export function addApply(data: Apply){
    return request({
        url: baseUrl,
        method: "post",
        data
    });
}

export function getMyApply(params:PageQuery){
    return request({
        url: baseUrl+"/me",
        method: "get",
        params
    });
}


export function getAllType(){
    return request({
        url: baseUrl+"/type",
        method: "get",
    });
}

export function deleteApply(id:Number){
    return request({
        url: baseUrl+"/"+id,
        method: "delete",
    });
}


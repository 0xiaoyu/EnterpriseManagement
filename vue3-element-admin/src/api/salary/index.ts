import request from "@/utils/request";
import {Salary, SalaryPageQuery} from "@/api/salary/types";
import {AxiosPromise} from "axios";


const baseUrl = "/salary";

export function getSalaryPage(params: SalaryPageQuery): AxiosPromise<Salary> {
  return request({
    url: `${baseUrl}`,
    method: "get",
    params,
  });
}
export function modifySalary(params: Salary): AxiosPromise<Boolean> {
  return request({
    url: `${baseUrl}`,
    method: "patch",
    params,
  });
}

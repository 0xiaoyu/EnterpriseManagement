const baseUrl = "/api/v1/notice"

export const getUserNoReadCount = () => {
  return {
    url: `${baseUrl}/count/noRead`,
    method: "GET",
  }
}

export function listNoRead(``){
  return {
    url: `${baseUrl}/list/noRead`,
    method: "GET",
  }
}

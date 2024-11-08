import { http } from '@/utils/http'

/**
 * 上传多个图片
 * @param {File[]} files - 图片文件数组
 * @returns {Promise} 上传结果
 */
export function uploadImagesAPI(files) {
  const formData = new FormData()

  // 将每个文件添加到 FormData 对象中
  files.forEach((file, index) => {
    formData.append('files', file) // 'files' 是后端接受的字段名，保持一致
  })

  return http({
    url: '/common/uploads',
    method: 'POST',

    data: formData
  })
}

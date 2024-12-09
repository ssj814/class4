package com.example.service.image;

import java.io.File;
import java.io.IOException;
import java.util.StringJoiner;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.dto.ProductReviewDTO;

@Service
public class ImageService {

	String baseDir = "C:/images/";

	// 이미지 저장
	public String saveImg(MultipartFile image, String subDir) {
		String uploadDir = baseDir + subDir + File.separator;
		UUID uuid = UUID.randomUUID();
		String imgName = uuid + image.getOriginalFilename();
		try {
			// 폴더없으면 생성
			File uploadDirectory = new File(uploadDir);
			if (!uploadDirectory.exists()) {
				uploadDirectory.mkdirs();
			}
			// 이미지 파일 저장
			File savedImageFile = new File(uploadDir + imgName);
			image.transferTo(savedImageFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return imgName;
	}
	
	// 이미지 여러개 저장
	public String saveMultipleImg(MultipartFile[] images, String subDir) {
	    StringJoiner imageNames = new StringJoiner(","); // 각 이미지 이름 사이에 콤마를 구분자로 사용
		try {
			if (!images[0].isEmpty()) {
				for (MultipartFile img : images) {
					String imgName = saveImg(img, subDir);
					//저장된 이미지 이름을 StringJoiner에 추가
					if (imgName != null) {
						imageNames.add(imgName);
	                }
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return imageNames.toString();
	}
	
	// 이미지 삭제
	public void deleteImg(String imgName, String subDir) {
		String uploadDir = baseDir + subDir + File.separator;
		File file = new File(uploadDir + imgName);
		file.delete(); // 파일이미지 삭제
	}
	
	// 이미지 여러개 삭제
	public void deleteMultipleImg(String imgNames, String subDir) {
		if (imgNames != null) {
			String[] imgNamesArray  = imgNames.split(",");
			for (String imgName : imgNamesArray ) {
				deleteImg(imgName,subDir);
			}
		}
	}
	
	// 이미지 수정
	@Transactional
	public String updateImg(MultipartFile image, String preImgName, String subDir) {
		String imgName = preImgName;
		if(!image.isEmpty()) {
			deleteImg(preImgName,subDir);
			imgName = saveImg(image,subDir);
		}
		return imgName;
	}
	
	// 이미지 여러개 수정
	@Transactional
	public String updateMultipleImg(MultipartFile[] images, String preImgNames, String subDir) {
		String imgName = preImgNames;
		if (!images[0].isEmpty()) {
			deleteMultipleImg(preImgNames, subDir);
			imgName = saveMultipleImg(images,subDir);
		}
		return imgName;
	}

}

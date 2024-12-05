package com.example.service.image;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.dto.ProductDTO;
import com.example.dto.ProductOptionDTO;
import com.example.service.shoppingmall.ProductService;

import lombok.RequiredArgsConstructor;

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
	
	// 이미지 삭제
	public void deleteImg(String imgName, String subDir) {
		String uploadDir = baseDir + subDir + File.separator;
		File file = new File(uploadDir + imgName);
		file.delete(); // 파일이미지 삭제
	}
	
	// 이미지 수정
	@Transactional
	public String updateImg(MultipartFile image, String preImgName, String subDir) {
		String imgName = null;
		
		if(!image.isEmpty()) {
			deleteImg(preImgName,subDir);
			imgName = saveImg(image,subDir);
		}
		
		return imgName;
	}

}

package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("ReportDTO")
public class ReportDTO {
	private int reportId;             // 신고 ID
	private String targetType;        // 분류 종류 (PRODUCT, POST, COMMENT)
    private int targetId;             // 신고 대상 ID (상품, 게시글, 댓글 등)
    private int reportTypeId;         // 신고 유형 ID (report_types 참조)
    private String title;             // 신고 제목
    private String content;           // 신고 내용
    private String reporterName;      // 신고자 이름
    private String reporterEmail;     // 신고자 이메일
    private String reporterPhone;     // 신고자 전화번호
    private String createdAt;         // 신고 생성 일시
    private String status;            // 처리 상태
    private String handlerId;         // 처리자 ID
    private String handledAt;         // 처리 일시
    private String comments;          // 처리 코멘트
    private String category;		  // 게시판 종류
    
    private String reportTypeName;
    

}

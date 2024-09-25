package com.example.dto;

import org.apache.ibatis.type.Alias;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("CommentDTO")
public class CommentDTO {
    private int id;
    private Integer parentId = 0;  // 대댓글인 경우 부모 댓글 ID, 없을 경우 null 처리
    private Integer postId;    // 게시글 ID, null 가능
    private String content;
    private String userid;
    private String createdate;
    private int repIndent;  // 댓글의 들여쓰기 수준
}

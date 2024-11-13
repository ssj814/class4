package com.example.dto;


import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("SicdanDTO")
public class SicdanDTO {

    private int sic_num;
    private String sic_title;
    private String content;
    private String writeday;
    private int readCnt;
    private String user_id;
    private char is_del;
    private int is_admin;
    private Date updateed_at;
    private String fileName;

}
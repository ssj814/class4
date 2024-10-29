package com.example.controller.sicdan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;
import com.example.dto.NdataDTO;
import com.example.service.sicdan.NdataService;

@Controller
public class ChartController {

    // NdataService를 주입받아 사용합니다.
    @Autowired
    NdataService service;

    // "/main" 경로로 GET 요청이 오면 실행되는 메서드
    @RequestMapping(value = "/Chart", method = RequestMethod.GET)
    public String list(Model m) {
        // 서비스로부터 데이터 리스트를 가져옵니다.
        List<NdataDTO> list = service.list();
        // 모델에 "list"라는 이름으로 데이터를 추가합니다.
        m.addAttribute("list", list);
        // "main"이라는 이름의 뷰를 반환합니다. (JSP를 사용할 경우 JSP 설정이 필요)
        return "sicdan/Chart";
    }

    // "/main" 경로로 POST 요청이 오면 실행되는 메서드
    @RequestMapping(value = "/Chart", method = RequestMethod.POST)
    @ResponseBody
    public NdataDTO idCheck(@RequestParam("gender") String gender) {
        NdataDTO data = null;
        try {
            // gender 파라미터를 정수로 변환
            int genderId = Integer.parseInt(gender);
            // 서비스로부터 genderId에 해당하는 데이터를 가져옵니다.
            data = service.genderNum(genderId);
        } catch (NumberFormatException e) {
            // 숫자로 변환할 수 없을 때 예외 처리
            e.printStackTrace();
        }
        // 결과를 반환합니다.
        return data;
    }

    // "/bmiForm" 경로로 요청이 오면 실행되는 메서드
    @RequestMapping(value = "/bmiForm")
    public String calculateBMI() {
        // "bmiForm"이라는 이름의 뷰를 반환합니다.
        return "sicdan/bmiForm";
    }

    // "/calculateBMI" 경로로 요청이 오면 실행되는 메서드
    @RequestMapping("/calculateBMI")
    public String calculateBMI(@RequestParam("height") String height, 
                               @RequestParam("weight") String weight, 
                               @RequestParam("age") String age,
                               @RequestParam("gender") String gender,
                               Model model) {
        // 키를 미터 단위로 변환합니다.
        double heightInMeters = Double.parseDouble(height) / 100;
        // 몸무게를 킬로그램으로 변환합니다.
        double weightInKg = Double.parseDouble(weight);
        // BMI를 계산합니다.
        double bmi = weightInKg / (heightInMeters * heightInMeters);

        // BMI 결과에 따른 분류와 색상을 결정합니다.
        String result;
        String bmiColor;
        if (bmi < 18.5) {
            result = "저체중"; // 저체중
            bmiColor = "blue"; // 파란색
        } else if (bmi < 23) {
            result = "정상"; // 정상
            bmiColor = "green"; // 녹색
        } else if (bmi < 25) {
            result = "과체중"; // 과체중
            bmiColor = "orange"; // 주황색
        } else if (bmi < 30) {
            result = "비만"; // 비만
            bmiColor = "red"; // 빨간색
        } else {
            result = "고도비만"; // 고도비만
            bmiColor = "darkred"; // 진한 빨간색
        }

        // 모델에 BMI 결과와 색상을 추가합니다.
        model.addAttribute("bmi", bmi);
        model.addAttribute("result", result);
        model.addAttribute("bmiColor", bmiColor);

        // "bmiResult"라는 이름의 뷰를 반환합니다.
        return "sicdan/bmiResult";
    }
}

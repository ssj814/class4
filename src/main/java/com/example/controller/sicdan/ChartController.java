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

    // NdataService를 주입하여 사용합니다. 이를 통해 데이터 접근 및 처리를 수행합니다.
    @Autowired
    private NdataService service;

    /**
     * "/Chart" 경로로 GET 요청이 들어오면 실행되는 메서드입니다.
     * 차트 데이터를 조회하여 뷰에 전달합니다.
     *
     * @param m Model 객체로, 뷰에 데이터를 전달하는 데 사용됩니다.
     * @return "sicdan/Chart" 뷰 이름을 반환하여 차트 페이지를 보여줍니다.
     */
    @RequestMapping(value = "/Chart", method = RequestMethod.GET)
    public String list(Model m) {
        // 서비스로부터 NdataDTO 리스트를 가져와 모델에 추가합니다.
        List<NdataDTO> list = service.list();
        m.addAttribute("list", list);
        
        // "sicdan/Chart" JSP 페이지로 이동합니다.
        return "sicdan/Chart";
    }

    /**
     * "/Chart" 경로로 POST 요청이 들어오면 실행되는 메서드입니다.
     * 성별 ID를 통해 해당 성별의 데이터가 있는지 확인합니다.
     *
     * @param gender 요청된 성별 ID 값 (문자열 형태)
     * @return 해당 성별 ID에 맞는 NdataDTO 객체를 반환합니다.
     */
    @RequestMapping(value = "/Chart", method = RequestMethod.POST)
    @ResponseBody
    public NdataDTO idCheck(@RequestParam("gender") String gender) {
        NdataDTO data = null;
        try {
            // gender를 숫자(genderId)로 변환하여, 서비스에서 해당 성별 데이터를 가져옵니다.
            int genderId = Integer.parseInt(gender);
            data = service.genderNum(genderId);
        } catch (NumberFormatException e) {
            // 문자열이 숫자로 변환되지 않을 경우 예외 처리를 수행합니다.
            e.printStackTrace();
        }
        // genderId에 해당하는 데이터를 반환합니다.
        return data;
    }

    /**
     * "/bmiForm" 경로로 요청이 들어오면 실행되는 메서드입니다.
     * BMI 계산 폼 페이지를 렌더링합니다.
     *
     * @return "sicdan/bmiForm" 뷰 이름을 반환하여 BMI 폼 페이지를 보여줍니다.
     */
    @RequestMapping(value = "/bmiForm")
    public String calculateBMI() {
        return "sicdan/bmiForm";
    }

    /**
     * "/calculateBMI" 경로로 요청이 들어오면 실행되는 메서드입니다.
     * 사용자의 키와 몸무게를 통해 BMI 지수를 계산하고 결과를 뷰에 전달합니다.
     *
     * @param height 사용자의 키 (cm 단위)
     * @param weight 사용자의 몸무게 (kg 단위)
     * @param age    사용자의 나이 (사용되지 않음)
     * @param gender 사용자의 성별 (사용되지 않음)
     * @param model  Model 객체로, 뷰에 데이터를 전달하는 데 사용됩니다.
     * @return "sicdan/bmiResult" 뷰 이름을 반환하여 BMI 결과 페이지를 보여줍니다.
     */
    @RequestMapping("/calculateBMI")
    public String calculateBMI(@RequestParam("height") String height, 
                               @RequestParam("weight") String weight, 
                               @RequestParam("age") String age,
                               @RequestParam("gender") String gender,
                               Model model) {
        // 키를 cm 단위에서 m 단위로 변환하여 BMI 계산에 사용합니다.
        double heightInMeters = Double.parseDouble(height) / 100;
        double weightInKg = Double.parseDouble(weight);
        
        // BMI 계산 공식: 몸무게(kg) / (키(m) * 키(m))
        double bmi = weightInKg / (heightInMeters * heightInMeters);

        // BMI 수치에 따라 결과 분류와 색상을 결정합니다.
        String result;
        String bmiColor;
        if (bmi < 18.5) {
            result = "저체중"; // BMI가 18.5 미만이면 저체중으로 분류
            bmiColor = "blue"; // 저체중인 경우 파란색
        } else if (bmi < 23) {
            result = "정상"; // BMI가 18.5 이상 23 미만이면 정상
            bmiColor = "green"; // 정상인 경우 녹색
        } else if (bmi < 25) {
            result = "과체중"; // BMI가 23 이상 25 미만이면 과체중
            bmiColor = "orange"; // 과체중인 경우 주황색
        } else if (bmi < 30) {
            result = "비만"; // BMI가 25 이상 30 미만이면 비만
            bmiColor = "red"; // 비만인 경우 빨간색
        } else {
            result = "고도비만"; // BMI가 30 이상이면 고도비만
            bmiColor = "darkred"; // 고도비만인 경우 진한 빨간색
        }

        // BMI 결과와 해당 분류, 색상을 모델에 추가하여 뷰로 전달합니다.
        model.addAttribute("bmi", bmi);
        model.addAttribute("result", result);
        model.addAttribute("bmiColor", bmiColor);

        // "sicdan/bmiResult" JSP 페이지로 이동합니다.
        return "sicdan/bmiResult";
    }
}

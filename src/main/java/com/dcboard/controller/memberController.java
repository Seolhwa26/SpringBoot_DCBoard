package com.dcboard.controller;

import ch.qos.logback.core.net.SyslogOutputStream;
import com.dcboard.model.member.MemberDTO;
import com.dcboard.service.memberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.HashMap;

@Controller
@RequiredArgsConstructor
public class memberController {

    private final memberService service;

    @RequestMapping(value = "/index")
    public String index() {

        return "index";
    }

    @GetMapping("/member/login")
    public String login() {

        return "member/login";
    }
    @PostMapping("/member/loginOk")
    public String loginOk(String id, String pw, HttpSession session, Model model) throws Exception {

        MemberDTO dto = service.loginCheck(id, pw);
        System.out.println(dto);
        String mseq = dto.getMseq();

        if (dto.getActive().equals("Y")) {
            //로그인 성공
            session.setAttribute("auth", id);
            session.setAttribute("mseq", mseq);

            return "redirect:/index";
        } else {
            //로그인 성공
            return "redirect:/member/login";
        }

    }

    @GetMapping("/member/logout")
    public String logout(HttpSession session) {

        session.removeAttribute("auth");
        session.removeAttribute("mseq");

        return "redirect:/index";
    }

    @GetMapping(value = "member/kakaoLogin")
    public String kakaoLogin(@RequestParam String code, HttpSession session) {
        String access_token = memberService.getKakaoAccessToken(code);

        HashMap<String, Object> memberKakaoInfo = memberService.kakaoMember(access_token);
        //System.out.println("login Controller : " + memberKakaoInfo);

        //클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
        if (memberKakaoInfo.get("email") != null) {
            session.setAttribute("id", memberKakaoInfo.get("id"));
            session.setAttribute("email", memberKakaoInfo.get("email"));
            session.setAttribute("access_token", access_token);
        }
        return "redirect:/index";
    }

    @GetMapping(value = "member/kakaoLogout")
    public String kakaoLogout(HttpSession session) {
        String access_token = (String)session.getAttribute("access_token");

        if(access_token != null && !"".equals(access_token)){
            memberService.kakaoLogout(access_token);
            session.removeAttribute("access_token");
            session.removeAttribute("email");
            session.removeAttribute("id");
        }else{
            System.out.println("access_Token is null");
        }
        return "redirect:/index";
    }

    @GetMapping("/about")
    public String about() {

        return "about";
    }

    @GetMapping("/blog")
    public String blog() {

        return "blog";
    }

    @GetMapping("/fragments/layout")
    public String layout() {

        return "fragments/layout";
    }

}

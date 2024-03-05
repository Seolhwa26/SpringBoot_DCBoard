package com.dcboard.mapper;

import com.dcboard.model.member.Member;
import com.dcboard.model.member.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;;

@Mapper
public interface memberMapper {

    MemberDTO loginCheck(@Param("id") String id, @Param("pw") String pw);

	String findId(Member member);

}

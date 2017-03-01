package com.shu.test;

import com.shu.db.model.follow.TFollow;
import com.shu.db.model.live.TLiveRoom;
import com.shu.db.model.live.TRoomBan;
import com.shu.db.model.live.TRoomManage;
import com.shu.db.model.user.TUser;
import com.shu.db.model.user.TUserInfo;
import com.shu.services.follow.TFollowService;
import com.shu.services.live.TLiveRoomService;
import com.shu.services.live.TRoomBanService;
import com.shu.services.live.TRoomManageService;
import com.shu.services.test.TestService;
import com.shu.services.user.TUserInfoService;
import com.shu.services.user.TUserService;
import com.shu.utils.UUID;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

/**
 * Created by admin on 2017/1/8.
 */
public class JunitTest {

    /**
     * This is just a test
     * 新创建的表请在下面进行测试
     */
    @Test
    public void testTest() {
        String[] paths = new String[] { "spring/applicationContext-bo.xml" };
        ApplicationContext ctx = new ClassPathXmlApplicationContext(paths);

        TUserInfoService ts = (TUserInfoService) ctx.getBean("userinfoService");
        TUserInfo userInfo = ts.getUserinfoById("8a37c3c8cb3f4c979d2cb85832a1f9d2");

        System.out.println(userInfo.getId());

//        TUser user = new TUser();
//        user.setUsername("jinyu");
//        TUser user2 = ts.getUserById("1");
//        System.out.println(user2.getPassword());

//        test.setId(UUID.getID());
//        ts.addTest(test);


//        List<TUser> list1 = ts.getUserListByParam(user, null, null);
//        for(TUser x : list1){
//            System.out.println(x.getPassword());
//        }
    }

    /**
     * 测试TLiveRoom的Service
     * 2017年2月28日 11:26:57测试通过
     */
    @Test
    public void TestTLiveRoom(){
        String[] paths = new String[] { "spring/applicationContext-bo.xml" };
        ApplicationContext ctx = new ClassPathXmlApplicationContext(paths);

        TLiveRoomService ts = (TLiveRoomService) ctx.getBean("lRoomService");
        TLiveRoom room = ts.getLRoomById("2");

        System.out.println(room.getApp());

        TLiveRoom queryRoom = new TLiveRoom();
        queryRoom.setIslive(1);

        List<TLiveRoom> list1 = ts.getLRoomListByParam(queryRoom, null, null);
        for(TLiveRoom x : list1){
            System.out.println(x.getApp());
        }
    }

    /**
     * 测试TFollow的Service
     * 2017年3月1日 14:30:53测试通过
     */
    @Test
    public void TestTFollow(){
        String[] paths = new String[] { "spring/applicationContext-bo.xml" };
        ApplicationContext ctx = new ClassPathXmlApplicationContext(paths);

        TFollowService ts = (TFollowService) ctx.getBean("followService");
        TFollow follow = ts.getFollowById("test");
        System.out.println(follow.getFanid());

        TFollow queryFollow = new TFollow();
        queryFollow.setFanid("fan");

        List<TFollow> list1 = ts.getFollowListByParam(queryFollow, null, null);
        for(TFollow x : list1){
            System.out.println(x.getFollowid());
        }
    }

    /**
     * 测试TRoomBan的Service
     * 2017年3月1日 15:55:16测试通过
     */
    @Test
    public void TestRoomBan(){
        String[] paths = new String[] { "spring/applicationContext-bo.xml" };
        ApplicationContext ctx = new ClassPathXmlApplicationContext(paths);

        TRoomBanService ts = (TRoomBanService) ctx.getBean("RBanService");
        TRoomBan tRoomBan = ts.getRoomBanById("test");

        System.out.println(tRoomBan.getRid());

        TRoomBan queryBan = new TRoomBan();
        queryBan.setUid("uid");

        List<TRoomBan> list1 = ts.getRoomBanListByParam(queryBan, null, null);
        for(TRoomBan x : list1){
            System.out.println(x.getRid());
        }
    }

    /**
     * 测试TRoomManage的Service
     * 2017年3月1日 15:55:22测试通过
     */
    @Test
    public void TestRoomManage(){
        String[] paths = new String[] { "spring/applicationContext-bo.xml" };
        ApplicationContext ctx = new ClassPathXmlApplicationContext(paths);

        TRoomManageService ts = (TRoomManageService) ctx.getBean("RManageService");
        TRoomManage tRoomManage = ts.getRManageById("test");

        System.out.println(tRoomManage.getRid());

        TRoomManage queryBan = new TRoomManage();
        queryBan.setUid("uid");

        List<TRoomManage> list1 = ts.getRManageListByParam(queryBan, null, null);
        for(TRoomManage x : list1){
            System.out.println(x.getRid());
        }
    }

}

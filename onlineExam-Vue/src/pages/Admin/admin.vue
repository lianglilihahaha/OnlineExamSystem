<template>
    <div class="profile">
        <!-- header -->
        <section class="profile-number">
            <div id="title">
                <a href="http://localhost:8090/#/home">
                <h1>在线考试系统</h1>
                <span>TESTONLINE</span>
                </a>
            </div>
            <router-link :to="userInfo.sno ? '/profile/info' : '/login'" class="profile-link">
                <div class="user-info">
                    <p class="user-info-top">{{userInfor.username}}</p>
                </div>
                <div class="profile_image">
                    <img :src="require('../../common/imgs/profile.jpg')" alt="学生头像">
                </div>
                <div class="user-info">
                    <p class="user-info-top">欢迎您：</p>
                </div>
            </router-link>
        </section>

        <!-- 侧边栏(导航) -->
        <div id="aside">
            <!-- <el-aside id="el_aside"> -->
                <el-row>
                    <el-col :span="24">
                        <el-menu default-active="1" background-color="#f5f5f5" active-text-color="#4ab8a1">
                            <el-menu-item index="1" @click="allPaper = true; 
                                                            questionShow = false; 
                                                            noticeShow = false;
                                                            allScore = false;
                                                            allUser = false;
                                                            allStudentScore = false;">
                                <i class="el-icon-user"></i>
                                <span slot="title">试卷管理</span>
                            </el-menu-item>
                            <el-menu-item index="2" @click="allPaper = false; 
                                                            questionShow = true; 
                                                            noticeShow = false;
                                                            allScore = false;
                                                            allUser = false;
                                                            allStudentScore = false;">
                                <i class="el-icon-tickets"></i>
                                <span slot="title">题库管理</span>
                            </el-menu-item>
                            <el-menu-item index="3" @click="allPaper = false; 
                                                            questionShow = false; 
                                                            noticeShow = true;
                                                            allScore = false;
                                                            allUser = false;
                                                            allStudentScore = false;">
                                <i class="el-icon-school"></i>
                                <span slot="title">公告管理</span>
                            </el-menu-item>
                            <el-menu-item index="4" @click="allPaper = false; 
                                                            questionShow = false; 
                                                            noticeShow = false;
                                                            allScore = true;
                                                            allStudentScore = false;
                                                            allUser = false;">
                                <i class="el-icon-school"></i>
                                <span slot="title">成绩管理</span>
                            </el-menu-item>
                            <el-menu-item index="5" @click="allPaper = false; 
                                                            questionShow = false; 
                                                            noticeShow = false;
                                                            allScore = false;
                                                            allStudentScore = false;
                                                            allUser = true">
                                <i class="el-icon-school"></i>
                                <span slot="title">人员管理</span>
                            </el-menu-item>
                        </el-menu>
                    </el-col>
                </el-row>
            <!-- </el-aside> -->
        </div>

        <!-- List -->
        <el-main id="List">
            <!-- 试卷 -->
            <el-card v-show="allPaper" id="testYes">
                <div slot="header" class="clearfix">
                    <el-row :gutter="10">
                        <el-col :span="8">
                            <el-input v-model="searchPaper" placeholder="请输入需要搜索的试卷名称"></el-input>
                        </el-col>
                        <el-col :span="5">
                            <el-button type="success" plain @click="searchPapers()">搜索</el-button>
                        </el-col>
                    </el-row>
                </div>
                <el-table :data="tableData1.slice((currentPage1-1)*pagesize,currentPage1*pagesize)" style="width: 100%">
                    <el-table-column align="center" prop="paperId" label="试卷编号"></el-table-column>
                    <el-table-column align="center" prop="paperName" label="试卷名称"></el-table-column>
                    <el-table-column align="center" prop="operation" label="操作">
                        <template slot-scope="scope">
                            <el-button type="success" 
                                icon="el-icon-edit" 
                                title="修改试卷名称" 
                                circle 
                                plain
                                @click="changePaperName(scope.$index, scope.row);"></el-button>
                        </template>
                        <!-- <el-button type="danger" icon="el-icon-delete" title="删除" @click="dele" plain>删除</el-button> -->
                    </el-table-column>
                    <div class="pagination">
                        <el-pagination background layout="prev, pager, next" :total="total1" @current-change="current_change1" class="paginate"></el-pagination>
                    </div>
                </el-table>
            </el-card>
            <!-- 题库管理 -->
            <el-card v-show="questionShow">
                <div slot="header" class="clearfix">
                    <el-row :gutter="10">
                        <el-col :span="8">
                            <el-input v-model="searchQuestion" placeholder="请输入需要搜索的试卷名称"></el-input>
                        </el-col>
                        <el-col :span="5">
                            <el-button type="success" plain @click="searchQuestionBtn()">搜索</el-button>
                        </el-col>
                        <el-col :span="9" style="text-align:right">
                            <el-button type="success" plain @click="addQuestionShow=true">新增题目</el-button>
                        </el-col>
                    </el-row>
                </div>
                <el-table :data="tableData2.slice((currentPage2-1)*pagesize,currentPage2*pagesize)" style="width: 100%" id="peoTable">
                    <el-table-column align="center" prop="exerciseId" label="题目编号"></el-table-column>
                    <el-table-column align="center" prop="content" label="题目"></el-table-column>
                    <el-table-column align="center" prop="exerciseType" label="题型"></el-table-column>
                    <el-table-column align="center" prop="paperDetailId" label="所在试卷编号"></el-table-column>
                    <el-table-column align="center" prop="answer" label="正确答案"></el-table-column>
                    <el-table-column align="center" prop="score" label="分值"></el-table-column>
                </el-table>
                <div class="pagination">
                    <el-pagination background layout="prev, pager, next" :total="total2" @current-change="current_change2" class="paginate"></el-pagination>
                </div>
            </el-card>
            <!-- 公告管理 -->
            <el-card v-show="noticeShow">
                <div slot="header" class="clearfix" style="text-align: right">
                    <el-button type="success" plain @click="addNoticeShow=true">新增公告</el-button>
                </div>
                <el-table :data="tableData3.slice((currentPage3-1)*pagesize,currentPage3*pagesize)" style="width: 100%" id="peoTable">
                    <el-table-column width="80px" align="center" prop="noticeId" label="公告编号"></el-table-column>
                    <el-table-column width="80px" align="center" prop="userId" label="发布者ID"></el-table-column>
                    <el-table-column align="center" prop="title" label="标题"></el-table-column>
                    <el-table-column align="center" prop="content" label="内容"></el-table-column>
                    <el-table-column align="center" prop="createTime" label="发布时间"></el-table-column>
                </el-table>
                <div class="pagination">
                    <el-pagination background layout="prev, pager, next" :total="total3" @current-change="current_change3" class="paginate"></el-pagination>
                </div>
            </el-card>

            <!-- 成绩 -->
            <el-card v-show="allScore">
                <el-table :data="tableData4.slice((currentPage4-1)*pagesize,currentPage4*pagesize)" style="width: 100%">
                    <el-table-column align="center" prop="paperId" label="试卷编号"></el-table-column>
                    <el-table-column align="center" prop="paperName" label="试卷名称"></el-table-column>
                    <el-table-column align="center" prop="operation" label="操作">
                        <template slot-scope="scope">
                            <el-button type="success" 
                                icon="el-icon-search" 
                                title="查看本卷考生成绩" 
                                circle 
                                plain
                                @click="showAllScore(scope.$index, scope.row);"></el-button>
                        </template>
                        <!-- <el-button type="danger" icon="el-icon-delete" title="删除" @click="dele" plain>删除</el-button> -->
                    </el-table-column>
                    <div class="pagination">
                        <el-pagination background layout="prev, pager, next" :total="total4" @current-change="current_change4" class="paginate"></el-pagination>
                    </div>
                </el-table>
            </el-card>

            <!-- 根据试卷列出考生成绩信息 -->
            <el-card v-show="allStudentScore">
                <el-table :data="tableData5.slice((currentPage5-1)*pagesize,currentPage5*pagesize)" style="width: 100%">
                    <el-table-column width="130px" align="center" prop="paperId" label="试卷编号"></el-table-column>
                    <el-table-column align="center" prop="paperName" label="试卷名称"></el-table-column>
                    <el-table-column width="130px" align="center" prop="userId" label="学生学号"></el-table-column>
                    <el-table-column width="130px" align="center" prop="username" label="学生姓名"></el-table-column>
                    <el-table-column width="130px" align="center" prop="mark" label="学生成绩"></el-table-column>
                    <div class="pagination">
                        <el-pagination background layout="prev, pager, next" :total="total5" @current-change="current_change5" class="paginate"></el-pagination>
                    </div>
                </el-table>
            </el-card>

            <!-- 列出所有用户信息 -->
            <el-card v-show="allUser">
                <el-table :data="tableData6.slice((currentPage6-1)*pagesize,currentPage6*pagesize)" style="width: 100%">
                    <el-table-column width="100px" align="center" prop="userId" label="用户ID"></el-table-column>
                    <el-table-column align="center" prop="username" label="用户名"></el-table-column>
                    <el-table-column width="100px" align="center" prop="password" label="密码"></el-table-column>
                    <el-table-column width="100px" align="center" prop="birthday" label="生日"></el-table-column>
                    <el-table-column width="100px" align="center" prop="sex" label="性别"></el-table-column>
                    <el-table-column width="100px" align="center" prop="power" label="权限"></el-table-column>
                    <el-table-column width="100px" align="center" prop="image" label="头像"></el-table-column>
                    <el-table-column align="center" prop="operation" label="操作">
                        <template slot-scope="scope">
                            <el-col :span="10">
                                <el-button type="danger" 
                                icon="el-icon-delete" 
                                title="删除" 
                                circle 
                                plain
                                @click="deleteUser(scope.$index, scope.row);"></el-button>
                            </el-col>
                            <el-col :span="10">
                                <el-button type="success" 
                                    icon="el-icon-edit" 
                                    title="修改用户限权" 
                                    circle 
                                    plain
                                    @click="updateUserPower(scope.$index, scope.row);"></el-button>
                            </el-col>
                        </template>
                    </el-table-column>
                    <div class="pagination">
                        <el-pagination background layout="prev, pager, next" :total="total6" @current-change="current_change6" class="paginate"></el-pagination>
                    </div>
                </el-table>
            </el-card>
        </el-main>

        <!-- 新增公告 -->
        <el-dialog id="addNotice" :visible="addNoticeShow">
            <el-form v-model="addNoticeInfor" ref="addNoticelInfor" label-width="150px">
                <el-form-item label="标题：" prop="title">
                    <el-col :span="8">
                        <el-input v-model="addNoticeInfor.title" placeholder="请输入标题"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="内容：" prop="content">
                    <el-col :span="20">
                        <el-input 
                            v-model="addNoticeInfor.content" 
                            type="textarea" 
                            placeholder="请编辑公告内容"
                            size="medium">
                        </el-input>
                    </el-col>
                </el-form-item>
                <el-form-item id="slotBtn">
                    <el-button type="success" icon="el-icon-check" @click="addNoticeShow=false; submiaddNotice()">确认修改</el-button>
                    <el-button type="primary" icon="el-icon-refresh-right" @click="reset('addNoticelInfor')">重置</el-button>
                    <el-button type="danger" icon="el-icon-close" @click="addNoticeShow=false; reset('addNoticelInfor')">取消</el-button>
                </el-form-item>
            </el-form>
        </el-dialog>

        <!-- 新增题目 -->
        <el-dialog id="addQuestion" :visible="addQuestionShow">
            <el-form v-model="addQuestionInfor" ref="addQuestionlInfor" label-width="150px">
                <el-form-item label="试卷编号：" prop="paperIdStr">
                    <el-col :span="8">
                        <el-input v-model="addQuestionInfor.paperIdStr" placeholder="请输入试卷编号"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="题目编号：" prop="exerciseIdStr">
                    <el-col :span="8">
                        <el-input v-model="addQuestionInfor.exerciseIdStr" placeholder="请输入题目编号"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="题目类型：" prop="exerciseTypeStr">
                    <el-col :span="8">
                        <el-input v-model="addQuestionInfor.exerciseTypeStr" placeholder="请输入题目类型"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="题目内容：" prop="contentStr">
                    <el-col :span="20">
                        <el-input 
                            v-model="addQuestionInfor.contentStr" 
                            type="textarea" 
                            placeholder="请编辑公告内容"
                            size="medium">
                        </el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="选项A：" prop="typeAStr">
                    <el-col :span="10">
                        <el-input v-model="addQuestionInfor.typeAStr" placeholder="请输入A选项"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="选项B：" prop="typeBStr">
                    <el-col :span="10">
                        <el-input v-model="addQuestionInfor.typeBStr" placeholder="请输入B选项"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="选项C：" prop="typeCStr">
                    <el-col :span="10">
                        <el-input v-model="addQuestionInfor.typeCStr" placeholder="请输入C选项"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="选项D：" prop="typeDStr">
                    <el-col :span="10">
                        <el-input v-model="addQuestionInfor.typeDStr" placeholder="请输入D选项"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="正确答案：" prop="answerStr">
                    <el-col :span="8">
                        <el-input v-model="addQuestionInfor.answerStr" placeholder="请输入正确答案"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item label="分值：" prop="scoreStr">
                    <el-col :span="8">
                        <el-input v-model="addQuestionInfor.scoreStr" placeholder="请输入分值"></el-input>
                    </el-col>
                </el-form-item>
                <el-form-item id="slotBtn">
                    <el-button type="success" icon="el-icon-check" @click="addQuestionShow=false; submiaddQuestion()">确认增加</el-button>
                    <el-button type="primary" icon="el-icon-refresh-right" @click="reset('addQuestionInfor')">重置</el-button>
                    <el-button type="danger" icon="el-icon-close" @click="addQuestionShow=false; reset('addQuestionInfor')">取消</el-button>
                </el-form-item>
            </el-form>
        </el-dialog>

        
    </div>
</template>

<script>
import HeaderTop from '../../components/HeaderTop/HeaderTop.vue'
import ProfileItem from '../../components/ProfileItem/ProfileItem.vue'
import { mapState, mapGetters } from 'vuex'
import { MessageBox, Toast } from 'mint-ui';
import {reqUpdateFeedbackStatus, reqFeedbackInfo} from '../../api'
export default {
    data() {
        return {
            sno:this.$store.state.userInfo.sno,
            isSelect:false,
            //一页表中的数据记录条数
            pagesize: 10,
            //试卷管理
            tableData1: [],
            allPaper: true,
            //分页
            currentPage1: 1,
            total1: 0,
            //查询
            searchPaper: '',

            //题库管理
            tableData2: [],
            questionShow: false,
            //分页
            currentPage2: 1,
            total2: 0,
            searchQuestion: '',
            //新增
            addQuestionShow: false,
            addQuestionInfor: [{
                    paperIdStr: '',
                    exerciseTypeStr: '',
                    exerciseIdStr: '',
                    contentStr: '',
                    typeAStr: '',
                    typeBStr: '',
                    typeCStr: '',
                    typeDStr: '',
                    answerStr: '',
                    scoreStr: '',
                }],

            //公告管理
            tableData3: [],
            noticeShow: false,
            //新增
            addNoticeShow: false,
            addNoticeInfor: [{
                title: '',
                content: '',
            }],
            //分页
            currentPage3: 1,
            total3: 0,

            //成绩管理
            allScore: false,
            tableData4: [],
            //分页
            currentPage4: 1,
            total4: 0,
            allStudentScore: false,
            tableData5: [],
            //分页
            currentPage5: 1,
            total5: 0,

            //用户管理
            allUser: false,
            tableData6: [],
            currentPage6: 1,
            total6: 0,
            //用户信息
            userInfor: []

        }
    },
    components:{
      HeaderTop,
      ProfileItem
    },
    computed:{
      ...mapState(['userInfo']),
      ...mapGetters(['unreadMsgCount'])
    },
    methods: {
        //分页
        current_change1(currentPage) {
            this.currentPage1 = currentPage;
        },
        current_change2(currentPage) {
            this.currentPage2 = currentPage;
        },
        current_change3(currentPage) {
            this.currentPage3 = currentPage;
        },
        current_change4(currentPage) {
            this.currentPage4 = currentPage;
        },
        current_change5(currentPage) {
            this.currentPage5 = currentPage;
        },
        current_change6(currentPage) {
            this.currentPage6 = currentPage;
        },
        //搜索试卷
        searchPapers() {
            this.$ajax({
                method: "post",
                url: "http://47.103.10.220:8010/paper/queryPaperName",
                data: {
                    keyStr: this.searchPaper,
                },
                dataType: "json",
                crossDomain: true,
                cache: false,
                transformRequest(obj){
                    var str = [];
                    for(var p in obj){
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    }
                    return str.join("&");
                },
            }).then(resolve => {
                this.tableData1 = resolve.data;
                //获取数组长度赋值给total
                this.total1 = resolve.data.length;
                // console.log(resolve.data);
            }, reject => {
                    // this.peoLoading = true;
                    console.log(reject);
            });
        },
        //修改试卷名称
        changePaperName(index, row) {
            this.$prompt('请输入新的试卷名称', '修改试卷名称', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
            }).then(({ value }) => {
                // console.log(value);
                this.$ajax({
                    method: "post",
                    url: "http://47.103.10.220:8010/paper/updatePaper",
                    data: {
                        paperIdStr: row.paperId,
                        paperName: value,
                    },
                    dataType: "json",
                    crossDomain: true,
                    cache: false,
                    transformRequest(obj){
                        var str = [];
                        for(var p in obj){
                            str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                        }
                        return str.join("&");
                    },
                }).then(resolve => {
                    this.$ajax({
                        method: "post",
                        url: "http://47.103.10.220:8010/paper/listAllPaper",
                        dataType: "json",
                        crossDomain: true,
                        cache: false,
                    }).then(resolve => {
                        this.tableData1 = resolve.data;
                        //获取数组长度赋值给total
                        this.total1 = resolve.data.length;
                        // console.log(resolve.data);
                    }, reject => {
                        // this.peoLoading = true;
                        console.log(reject);
                    });
                }, reject => {
                    // this.peoLoading = true;
                    console.log(reject);
                });
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '取消输入'
                });       
            });
        },
        //重置
        reset(formdate) {
            this.$refs[formdate].resetFields();
        },
        //提交新增公告
        submiaddNotice() {
            this.$ajax({
                method: "post",
                url: "http://47.103.10.220:8010/notice/addNotice",
                dataType: "json",
                data: {
                    title: this.addNoticeInfor.title,
                    content: this.addNoticeInfor.content,
                },
                crossDomain: true,
                cache: false,
                transformRequest(obj){
                    var str = [];
                    for(var p in obj){
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    }
                    return str.join("&");
                },
            }).then(resolve => {
                this.$ajax({
                    method: "post",
                    url: "http://47.103.10.220:8010/notice/listAllNotice",
                    dataType: "json",
                    crossDomain: true,
                    cache: false,
                }).then(resolve => {
                    this.tableData3 = resolve.data;
                    //获取数组长度赋值给total
                    this.total3 = resolve.data.length;
                    console.log(this.tota3);
                    // console.log(resolve.data);
                }, reject => {
                    console.log(reject);
                });
            }, reject => {
                console.log("failed request!");
            });
        },

        //查看试卷对应的所有考生成绩
        showAllScore(index, row) {
            this.allStudentScore = true;
            this.allScore = false;
            console.log(row.paperId);
            this.$ajax({
                method: "post",
                url: "http://47.103.10.220:8010/score/queryScoreByPaper",
                data: {
                    paperIdStr: row.paperId,
                },
                dataType: "json",
                crossDomain: true,
                cache: false,
                transformRequest(obj){
                    var str = [];
                    for(var p in obj){
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    }
                    return str.join("&");
                },
            }).then(resolve => {
                this.tableData5 = resolve.data;
                //获取数组长度赋值给total
                this.total5 = resolve.data.length;
                // console.log(resolve.data);
            }, reject => {
                    // this.peoLoading = true;
                    console.log(reject);
            });
        },

        //搜索题目
        searchQuestionBtn() {
            this.$ajax({
                method: "post",
                url: "http://47.103.10.220:8010/paperDetail/queryPaperDetail",
                data: {
                    keyStr: this.searchQuestion,
                },
                dataType: "json",
                crossDomain: true,
                cache: false,
                transformRequest(obj){
                    var str = [];
                    for(var p in obj){
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    }
                    return str.join("&");
                },
            }).then(resolve => {
                this.tableData2 = resolve.data;
                //获取数组长度赋值给total
                this.total2 = resolve.data.length;
                // this.peoLoading = false;
                console.log(this.total2);
                // console.log(resolve.data);
            }, reject => {
                console.log(reject);
            });
        },
        //提交新增的题目
        submiaddQuestion() {
            // console.log("hahaha");
            // console.log(this.addQuestionInfor.paperIdStr, this.addQuestionInfor.exerciseTypeStr, this.addQuestionInfor.exerciseIdStr)
            // console.log(this.addQuestionInfor.contentStr, this.addQuestionInfor.typeAStr, this.addQuestionInfor.typeBStr)
            // console.log(this.addQuestionInfor.typeCStr, this.addQuestionInfor.typeDStr, this.addQuestionInfor.answerStr)
            // console.log(this.addQuestionInfor.scoreStr)
            this.$ajax({
                method: "post",
                url: "http://47.103.10.220:8010/paperDetail/addPaperDetail",
                data: {
                    paperIdStr: this.addQuestionInfor.paperIdStr,
                    exerciseTypeStr: this.addQuestionInfor.exerciseTypeStr,
                    exerciseIdStr: this.addQuestionInfor.exerciseIdStr,
                    contentStr: this.addQuestionInfor.contentStr,
                    typeAStr: this.addQuestionInfor.typeAStr,
                    typeBStr: this.addQuestionInfor.typeBStr,
                    typeCStr: this.addQuestionInfor.typeCStr,
                    typeDStr: this.addQuestionInfor.typeDStr,
                    answerStr: this.addQuestionInfor.answerStr,
                    scoreStr: this.addQuestionInfor.scoreStr,
                },
                dataType: "json",
                crossDomain: true,
                cache: false,
                transformRequest(obj){
                    var str = [];
                    for(var p in obj){
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    }
                    return str.join("&");
                },
            }).then(resolve => {
                console.log(resolve);
                this.$ajax({
                    method: "post",
                    url: "http://47.103.10.220:8010/paperDetail/listAllPaperDetail",
                    dataType: "json",
                    crossDomain: true,
                    cache: false,
                }).then(resolve => {
                    this.tableData2 = resolve.data;
                    //获取数组长度赋值给total
                    this.total2 = resolve.data.length;
                    // this.peoLoading = false;
                    console.log(this.total2);
                    // console.log(resolve.data);
                }, reject => {
                    // this.peoLoading = true;
                    console.log(reject);
                });
            }, reject => {
                console.log(reject);
            });
        },

        //删除用户
        deleteUser(index, row) {
            this.$ajax({
                method: "post",
                url: "http://47.103.10.220:8010/user/deleteUser",
                data: {
                    userIdStr: row.userId,
                },
                dataType: "json",
                crossDomain: true,
                cache: false,
                transformRequest(obj){
                    var str = [];
                    for(var p in obj){
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    }
                    return str.join("&");
                },
            }).then(resolve => {
               this.$ajax({
                    method: "post",
                    url: "http://47.103.10.220:8010/user/listAllUser",
                    dataType: "json",
                    crossDomain: true,
                    cache: false,
                }).then(resolve => {
                    this.tableData6 = resolve.data;
                    //获取数组长度赋值给total
                    this.total6 = resolve.data.length;
                    // this.peoLoading = false;
                    console.log(this.total1);
                    // console.log(resolve.data);
                }, reject => {
                    // this.peoLoading = true;
                    console.log(reject);
                });
            }, reject => {
                console.log(reject);
            });
        },
        //修改用户限权
        updateUserPower(index, row) {
            this.$ajax({
                method: "post",
                url: "http://47.103.10.220:8010/user/updatePower",
                data: {
                    userIdStr: row.userId,
                },
                dataType: "json",
                crossDomain: true,
                cache: false,
                transformRequest(obj){
                    var str = [];
                    for(var p in obj){
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    }
                    return str.join("&");
                },
            }).then(resolve => {
               this.$ajax({
                    method: "post",
                    url: "http://47.103.10.220:8010/user/listAllUser",
                    dataType: "json",
                    crossDomain: true,
                    cache: false,
                }).then(resolve => {
                    this.tableData6 = resolve.data;
                    //获取数组长度赋值给total
                    this.total6 = resolve.data.length;
                    // this.peoLoading = false;
                    console.log(this.total1);
                    // console.log(resolve.data);
                }, reject => {
                    // this.peoLoading = true;
                    console.log(reject);
                });
            }, reject => {
                console.log(reject);
            });
        }
    },
    created() {
        //获取用户信息
        this.$ajax({
          method: "post",
          url: "http://47.103.10.220:8010/user/listUserById",
          dataType: "json",
          crossDomain: true,
          cache: false,
        }).then(resolve => {
            console.log(resolve);
            this.userInfor = resolve.data[0];
        }, reject => {
            // this.peoLoading = true;
            console.log(reject);
        });
        //试卷管理
        this.$ajax({
            method: "post",
            url: "http://47.103.10.220:8010/paper/listAllPaper",
            dataType: "json",
            crossDomain: true,
            cache: false,
        }).then(resolve => {
            this.tableData1 = resolve.data;
            //获取数组长度赋值给total
            this.total1 = resolve.data.length;
            // this.peoLoading = false;
            console.log(this.total1);
            // console.log(resolve.data);
        }, reject => {
            // this.peoLoading = true;
            console.log(reject);
        });
        //题库管理
        this.$ajax({
            method: "post",
            url: "http://47.103.10.220:8010/paperDetail/listAllPaperDetail",
            dataType: "json",
            crossDomain: true,
            cache: false,
        }).then(resolve => {
            this.tableData2 = resolve.data;
            //获取数组长度赋值给total
            this.total2 = resolve.data.length;
            // this.peoLoading = false;
            console.log(this.total2);
            // console.log(resolve.data);
        }, reject => {
            // this.peoLoading = true;
            console.log(reject);
        });
        //公告管理
        this.$ajax({
            method: "post",
            url: "http://47.103.10.220:8010/notice/listAllNotice",
            dataType: "json",
            crossDomain: true,
            cache: false,
        }).then(resolve => {
            this.tableData3 = resolve.data;
            //获取数组长度赋值给total
            this.total3 = resolve.data.length;
            console.log(this.tota3);
            // console.log(resolve.data);
        }, reject => {
            console.log(reject);
        });
        //成绩管理
        this.$ajax({
            method: "post",
            url: "http://47.103.10.220:8010/paper/listAllPaper",
            dataType: "json",
            crossDomain: true,
            cache: false,
        }).then(resolve => {
            this.tableData4 = resolve.data;
            //获取数组长度赋值给total
            this.total4 = resolve.data.length;
            // this.peoLoading = false;
            console.log(this.total4);
            // console.log(resolve.data);
        }, reject => {
            // this.peoLoading = true;
            console.log(reject);
        });
        //用户管理
        this.$ajax({
            method: "post",
            url: "http://47.103.10.220:8010/user/listAllUser",
            dataType: "json",
            crossDomain: true,
            cache: false,
        }).then(resolve => {
            this.tableData6 = resolve.data;
            //获取数组长度赋值给total
            this.total6 = resolve.data.length;
            // this.peoLoading = false;
            console.log(this.total1);
            // console.log(resolve.data);
        }, reject => {
            // this.peoLoading = true;
            console.log(reject);
        });
    }
}
</script>
<style lang="stylus" type="text/stylus" rel="stylesheet/stylus" scoped>
  @import "../../common/stylus/mixins.styl"
  .profile
    width 100%
    overflow hidden
    padding-bottom 56px
    .profile-number
      // margin-top 45.5px
      &:active
        opacity 0.8
      .profile-link
        clearFix()
        position relative
        display block
        background lightslategrey
        padding 20px 10px
        .profile_image
          float right
          width 60px
          height 60px
          border-radius 50%
          overflow hidden
          vertical-align top
          img
            height 100%
            width 100%
          .icon-yonghuming
            background #e4e4e4
            font-size 62px
        .user-info
          float right
          margin-top 23px
          margin-left 15px
          p
            font-weight: 700
            font-size 18px
            color #fff
            &.user-info-top
              padding-bottom 8px
            .icon-msnui-tel
              font-size 14px
              color #fff
        .arrow
          position absolute
          right 15px
          top 40%
          .iconjiantou
            color #fff
            font-size 30px
    .profile-items
      .login_out
        height 50px
        display flex
        justify-content center
        align-items center
        background-color lightslategrey
        margin-top 6px
        color #fff
        //box-shadow 0px 0px 1px rgba(0,0,0,.5)
        &.opacity
          opacity 0.4
          background lightslategrey
  #title
    position absolute 
    // border 1px solid red
    z-index 1000
    left 2%
    top 4.5%
    line-height 25px
    text-align center
  #title a {
    color white
    font-weight 300
  }
  #title h1 {
    font-size 20px
  }
  /* header */
    #header {
        /* border: 1px solid #879b6f; */
        padding: 0;
    }
    #header_inner {
        text-align: center;
        background-color: #879b6f;
        padding: 0.6%;
    }
    #header_inner_text h1 {
        font-size: 24px;
        color: white;
    }
    #header_inner_text span {
        font-size: 15px;
    }
    #header_inner_text {
        width: 18%;
        line-height: 75%;
        /* border: 1px solid red; */
    }
    #header_inner_text a {
        color: white;
        text-decoration: none;
    }

    /* 侧边栏 */
    #aside {
        width: 13%;
        /* border: 1px solid; */
        margin-top: 1%;
    }

    /* 各个List */
    #List {
        width: 83%;
        position: absolute;
        top 112px
        left 15%
    }

    /* 分页 */
    .pagination {
        text-align: center;
    }
    /* 背景颜色 */
    /* .el-pagination .el-pager li {
        background-color: #879b6f;
    } */
</style>

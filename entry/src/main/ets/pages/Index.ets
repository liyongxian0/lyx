import router from '@ohos.router';
import Const from '../common/constants/CommonConstants'
import Logger from '../common/utils/Logger'

@Entry
@Component
struct Index {

  @State userName: string = '' //用户名使用手机号
  @State config: string = '' //手机验证码
  @State password: string = '' //密码
  @State isSelect: boolean = false //隐私协议是否勾选

  private userNameCheckReg = /^1[3|4|5|6|7|8|9][0-9]{9}/ //手机号校验规则

  build() {

    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {

      Text($r('app.string.App_title'))
        .fontSize($r('app.float.login_title_font_size')).fontWeight(Const.FONT_BOLDER)
        .fontColor($r('app.color.title'))

      if(!this.userNameCheckReg.test(this.userName) && this.userName !=''){
        Text($r('app.string.user_name_error_message'))
          .fontSize($r('app.float.login_error_message_font_size'))
          .fontWeight(Const.FONT_BOLDER)
          .textAlign(TextAlign.Center)
          .fontColor(Color.Red)
          .width(Const.CONTENT_SIZE)
      }

      Column() {
        TextInput({ placeholder: $r('app.string.Login_UserName') })
          .width('80%')
          .height($r('app.float.login_input_height'))
          .margin({ top: $r('app.float.login_input_margin_top') })
          .backgroundColor($r('app.color.textinput_background'))
          .onChange((value)=>{
            this.userName = value;
          })

        TextInput({ placeholder: $r('app.string.Login_Password') })
          .width('80%')
          .backgroundColor($r('app.color.textinput_background'))
          .type(InputType.Password)
          .height($r('app.float.login_input_height'))
          .margin({ top: $r('app.float.login_input_margin_top') })
          .onChange((value)=>{
            this.password = value;
          })
      }.width(Const.FULL_WIDTH)

      Button($r('app.string.Login')).width('60%').opacity($r('app.float.login_button_opacity'))
        .onClick(()=>{
          if(!this.isSelect){
            AlertDialog.show({
              title:'提示:',
              message:'请先同意隐私协议！',
              confirm:{
                value:'关闭',
                action:()=>{
                  console.info('confirm!!!')
                }
              }
            })
          }
          else if(this.password==='888'){
            Logger.error('Login:',`${this.userName}登录成功>>>>>`)
            console.info('login ok!')
            // 登录跳转

            router.pushUrl({
              url:'pages/Loading',
              params:{
                userNameParam:this.userName
              }
            })

          }else{
            Logger.error('Login:',`${this.userName}登录失败<<<<<<`)
            AlertDialog.show({
              title:'提示:',
              message:'用户名或密码错误！',
              confirm:{
                value:'关闭',
                action:()=>{
                  console.info('confirm!!!')
                }
              }
            })
          }
        })
      Row(){
        Text('忘记密码')
          .width(Const.HALF_SIZE)

          .textAlign(TextAlign.Center)
          .onClick(()=>{
            console.info('abc'+this.userName+'忘记密码')
            router.pushUrl({
              url:'pages/ForgetPwd'

            })
          })
        Text('注册账号')
          .width(Const.HALF_SIZE)

          .textAlign(TextAlign.Center)
          .onClick(()=>{
            console.info('注册成功！'+this.userName)
            router.pushUrl({
              url:'pages/Register'
            })
          })

      }.width(Const.FULL_WIDTH)
      Row() {
        Checkbox().select(this.isSelect).backgroundColor($r('app.color.login_select_background_color'))
          .onChange((value)=>{
            this.isSelect = value;
          })
        Text($r('app.string.Login_check_License')).fontColor($r('app.color.login_check_license_font_color'))
      }

    }
    .width(Const.FULL_WIDTH)
    .height(Const.FULL_HEIGHT)
    .backgroundImage($r('app.media.peak4'))
    .backgroundImageSize(ImageSize.Cover)

  }
}
import router from '@ohos.router';
import Const from '../Common/constants/CommonConstants';
@Entry
@Component
struct Register {
  @State message: string = '注册'
  @State userName : string = ''
  @State config: string = '' //验证码
  private userNameCheckReg = /^1[3|4|5|6|7|8|9][0-9]{9}/ //手机号校验规则

  build() {
    Flex({direction:FlexDirection.Column,justifyContent:FlexAlign.SpaceAround,alignItems:ItemAlign.Center}){

      Text('找回密码')
        .fontSize(30)
        .fontWeight(700)

        .width('95%')
        .textAlign(TextAlign.Center)
        .fontColor($r('app.color.title'))
      if(!this.userNameCheckReg.test(this.userName) && this.userName !=''){
        // Text($r('app.string.user_name_error_message'))
        //   .fontSize($r('app.float.login_error_message_font_size'))
        //   .fontWeight(Const.FONT_BOLDER)
        //   .textAlign(TextAlign.Center)
        //   .fontColor(Color.Red)
        //   .width(Const.CONTENT_SIZE)

      }
      Column({space:20}){
        TextInput({placeholder:'请输入用户名：'}).width('80%').type(InputType.PhoneNumber||InputType.Number)
          .onChange((val)=>{
            this.userName = val
          })
        Row(){
          TextInput({placeholder:'请输入短信验证码：'})
            .width('70%').type(InputType.Number)
            .onChange((value)=>{
              this.config = value;
            })
          Button('获取验证码').width('30%')
            .onClick(()=>{
              AlertDialog.show({
                message:'验证码已发送'
              })
            })

        }.width('80%')
      TextInput({placeholder:'请设置密码：'}).width('80%').type(InputType.Password)
      }.width(Const.FULL_WIDTH)

      Button('密码设置成功，返回登录页面').width('80%')
        .onClick(()=>{
          // AlertDialog.show({
          //   message:'密码设置成功，返回登录页面',
          //   confirm:{
          //     value:'关闭',
          //
          //     action:()=>{
          //       console.info('confirm!!!')
          //     }
          //   }
          // })
          //console.info('成功！'+this.userName)
          router.pushUrl({
            url:'pages/Index',
            params:{userNameParm:this.userName}
          })
        })


    }
  }
}
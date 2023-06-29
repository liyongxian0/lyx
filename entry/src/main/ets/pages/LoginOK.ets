import router from '@ohos.router';
@Entry
@Component
struct LoginOk {
  @State message: string = '[jerry]您好！欢迎登录！'
  @State userName2 :string = router.getParams()['userNameParm']

  build() {
    Row() {
      Column() {
        Text(`[${this.userName2}]您好！欢迎登录！`)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}
import router from '@ohos.router';
import Const from '../common/constants/CommonConstants'
@Entry
@Component
struct Loading {
  @State userName: string = router.getParams()['userNameParam']
  @State progValue: number = 50 //进度条初始值
  @State progColorValue: number = 50 //进度条颜色值
  private timer:number  //定时器


  build() {

    //justifyContent:主轴对齐（content主轴），alignItems:交叉轴对齐（item交差轴）
    Flex({direction:FlexDirection.Column,justifyContent:FlexAlign.SpaceEvenly,alignItems:ItemAlign.Center}){
      Text(`[${this.userName}]您好，系统正在登录...`).fontSize(20)
      Progress({ value: this.progValue, total: 150, type: ProgressType.Ring })
        .color(Color.Blue).value(this.progColorValue).width(150)
        .style({ strokeWidth: 20, scaleCount: 30, scaleWidth: 5 })

    }
    .width(Const.FULL_WIDTH)
    .height(Const.FULL_HEIGHT)

  }

  aboutToAppear(){
    if(this.progValue <= 150 && this.progColorValue <= 150){
      this.timer = setInterval(()=>{
        this.progValue += 50
        this.progColorValue += 50
      },1000)
    }
    setTimeout(()=>{
      clearInterval(this.timer)
      router.pushUrl({url:'pages/MainPage'})  //实现路由跳转到首页
    },3000)
  }
}
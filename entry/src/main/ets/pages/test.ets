import Const from '../Common/constants/CommonConstants'
@Entry
@Component
struct test {
  @State message: string = 'Hello World'
  build(){
    Text('云课堂').fontSize(35).fontWeight(Const.FONT_BOLDER)
  }
}
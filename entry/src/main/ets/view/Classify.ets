/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Constants from '../common/constants/CommonConstants';
import ClassifyModel from '../common/bean/ClassifyModel';
import CourseModel from '../common/bean/CourseModel';
import CourseItem from '../view/CourseItem';
import ClassifyItem from '../view/ClassityItem';
import ClassifyViewModel from '../viewmodel/ClassifyViewModel';

//@Entry
@Component
export default struct Classify {
  @State currentClassify: number = 0; // selected classify index.
  @State requestSuccess: boolean = false; // is loading data.
  private classifyList: Array<ClassifyModel> = [];
  private classifyScroller: Scroller = new Scroller();
  private scroller: Scroller = new Scroller();
  controller: SearchController = new SearchController()
  //private swiperController: SwiperController = new SwiperController();
  @State changeValue: string = ''
  @State submitValue: string = ''

  aboutToAppear() {
    // loading data.
    setTimeout(() => {
      this.classifyList = ClassifyViewModel.getLinkData();
      this.requestSuccess = true;
    }, Constants.LOADING_DURATION);
  }

  @Builder ClassifyHeader(classifyName: string) {
    Row() {
      Text(classifyName)
        .fontSize($r('app.float.header_font_size'))
        .fontColor($r('app.color.base_font_color'))
        .fontFamily($r('app.string.hei_ti_medium'))
        .fontWeight(Constants.TITLE_FONT_WEIGHT)
    }
    .padding({ left: $r('app.float.item_padding_left') })
    .height($r('app.float.classify_item_height'))
    .width(Constants.FULL_PERCENT)
    .backgroundColor($r('app.color.base_background'))
  }

  classifyChangeAction(index: number, isClassify: boolean) {
    if (this.currentClassify !== index) {
      // change the classify status.
      this.currentClassify = index;
      if (isClassify) {
        // scroll the course scroll.
        this.scroller.scrollToIndex(index);
      } else {
        // scroll the classify scroll.
        this.classifyScroller.scrollToIndex(index);
      }
    }
  }

  build() {
    Column(){
      Search({ value: this.changeValue, placeholder: 'Type to search...', controller: this.controller })
        .searchButton('搜索')
        .width(400)
        .height(40)
        .backgroundColor('#F5F5F5')
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14, weight: 400 })
        .textFont({ size: 14, weight: 400 })
          //.margin(20)
        .width('90%')
      Row() {
        if (this.requestSuccess) {
          List({ scroller: this.classifyScroller }) {
            ForEach(this.classifyList, (item: ClassifyModel, index: number) => {
              ListItem() {
                ClassifyItem({
                  classifyName: item.classifyName,
                  isSelected: this.currentClassify === index,
                  onClickAction: this.classifyChangeAction.bind(this, index, true)
                })
              }
            }, (item: ClassifyModel) => item.classifyName + this.currentClassify)
          }
          .height(Constants.FULL_PERCENT)
          .width($r('app.float.classify_item_width'))
          .backgroundColor($r('app.color.classify_background'))
          .scrollBar(BarState.Off)

          List({ scroller: this.scroller }) {
            ForEach(this.classifyList, (classifyItem: ClassifyModel) => {
              ListItemGroup({
                header: this.ClassifyHeader(classifyItem.classifyName),
                space: Constants.COURSE_ITEM_PADDING
              }) {
                ForEach(classifyItem.courseList, (courseItem: CourseModel) => {
                  ListItem() {
                    CourseItem({ itemStr: JSON.stringify(courseItem) })
                  }
                }, (courseItem: CourseModel) => `${courseItem.courseId}`)
              }
            }, (item: ClassifyModel) => `${item.classifyId}`)
          }
          .padding({ left: $r('app.float.item_padding_left'), right: $r('app.float.course_item_padding') })
          .sticky(StickyStyle.Header)
          .layoutWeight(1)
          .edgeEffect(EdgeEffect.None)
          .onScrollIndex((start: number) => this.classifyChangeAction(start, false))
        } else {
          Text($r('app.string.loading'))
            .fontFamily($r('app.string.hei_ti_medium'))
            .textAlign(TextAlign.Center)
            .height(Constants.FULL_PERCENT)
            .width(Constants.FULL_PERCENT)
        }
      }
      .backgroundColor($r('app.color.base_background'))
    }.width('100%')


  }
}
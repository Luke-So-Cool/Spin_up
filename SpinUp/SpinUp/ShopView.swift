//
//  ShopView.swift
//  SpinUp
//
//  Created by GOngTAE on 2023/01/27.
//

import SwiftUI
import PagingView


struct ShopView: View {
    @State private var activePageIndex: Int = 0
    let itemWidth: CGFloat = 180
    let itemPadding: CGFloat = 60
    @State var speed: CGFloat = 0.4
    
    var mockSpinner: [String] = [
        "blue",
        "orange",
        "green"
    ]
    
    //MARK: - Body
    var body: some View {
        
        ZStack {
            Color.backgroundBlack
            
            VStack {
                Spacer()
                    .frame(height: 150)
                
                //MARK: - 피젯스피너 H 그리드
                GeometryReader { geometry in
                        AdaptivePagingScrollView(currentPageIndex: self.$activePageIndex,
                                                 itemsAmount: 4,
                                                 itemWidth: self.itemWidth,
                                                 itemPadding: self.itemPadding,
                                                 pageWidth: geometry.size.width) {
                            ForEach(0..<5) { id in
                                GeometryReader { screen in
                                    Circle()
                                        .fill(.blue)
                                        .rotation3DEffect(Angle(degrees: (Double(screen.frame(in: .global).minX) - 20) / -15),
                                                          axis: (x: 0, y: 0, z: 90))
                                    
                                        .scaleEffect(activePageIndex == id ?? 0 ? 1.5 : 1)
                                }
                                .frame(width: self.itemWidth, height: 400)
                            }
                        }
                }
                
                Text("NAME")
                    .foregroundColor(.spinnerLabel)
                    .font(.custom("WallPoet", size: 32))
                
                HStack(spacing: 20) {
                    ZStack {
                        ActivityRingView(progress: $speed)
                            .animation(.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
                        Text("SPEED")
                            .foregroundColor(.spinnerLabel)
                            .font(.subheadline)
                    }
                    ZStack {
                        ActivityRingView(progress: $speed)
                            .animation(.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
                        Text("POWER")
                            .foregroundColor(.spinnerLabel)
                            .font(.subheadline)
                            
                    }
                    ZStack {
                        ActivityRingView(progress: $speed)
                            .animation(.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
                        Text("MASS")
                            .foregroundColor(.spinnerLabel)
                            .font(.subheadline)
                    }
                }
            
                .frame(height: 100)
                .padding(20)
                
                
                //Rectangle 41
                ZStack {
                    Text("")
                    
                    RoundedRectangle(cornerRadius: 53)
                        .strokeBorder(Color(#colorLiteral(red: 0.9803921580314636, green: 0.9960784316062927, blue: 0.9921568632125854, alpha: 1)), lineWidth: 1)
                        .shadow(color: Color("SpinnerCyan"), radius: 10)
                }
                .frame(width: 330, height: 52)
                
                
                
                Spacer()
                    .frame(height: 60)
            }
        }
        .ignoresSafeArea()
    }
}

struct ActivityRingView: View {
    @Binding var progress: CGFloat
    
    var colors: [Color] = [Color.spinnerLabel, Color.spinnerLabel]
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.spinnerLabel2, lineWidth: 5)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: colors),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
            ).rotationEffect(.degrees(-90))
            Circle()
                .frame(width: 5, height: 5)
                .foregroundColor(Color.spinnerLabel)
                .offset(y: -50)
            Circle()
                .frame(width: 5, height: 5)
                .foregroundColor(progress > 0.95 ? Color.red: Color.red.opacity(0))
                .offset(y: -120)
                .rotationEffect(Angle.degrees(360 * Double(progress)))
                .shadow(color: progress > 0.96 ? Color.black.opacity(0.1): Color.clear, radius: 3, x: 4, y: 0)
        }
        .frame(idealWidth: 96, idealHeight: 96, alignment: .center)
    }
}

struct AdaptivePagingScrollView: View {
    
    private let items: [AnyView]
    private let itemPadding: CGFloat
    private let itemSpacing: CGFloat
    private let itemWidth: CGFloat
    private let itemsAmount: Int
    private let contentWidth: CGFloat
    
    private let leadingOffset: CGFloat
    private let scrollDampingFactor: CGFloat = 0.66
    
    @Binding var currentPageIndex: Int
    
    @State private var currentScrollOffset: CGFloat = 0
    @State private var gestureDragOffset: CGFloat = 0
    
    init<A: View>(currentPageIndex: Binding<Int>,
                  itemsAmount: Int,
                  itemWidth: CGFloat,
                  itemPadding: CGFloat,
                  pageWidth: CGFloat,
                  @ViewBuilder content: () -> A) {

        let views = content()
        self.items = [AnyView(views)]

        self._currentPageIndex = currentPageIndex

        self.itemsAmount = itemsAmount
        self.itemSpacing = itemPadding
        self.itemWidth = itemWidth
        self.itemPadding = itemPadding
        self.contentWidth = (itemWidth+itemPadding)*CGFloat(itemsAmount)

        let itemRemain = (pageWidth-itemWidth-2*itemPadding)/2
        self.leadingOffset = itemRemain + itemPadding
    }

    // 01
    private func countOffset(for pageIndex: Int) -> CGFloat {
        
        let activePageOffset = CGFloat(pageIndex) * (itemWidth + itemPadding)
        return leadingOffset - activePageOffset
    }
    
    // 02
    private func countPageIndex(for offset: CGFloat) -> Int {
        
        guard itemsAmount > 0 else { return 0 }
        
        let offset = countLogicalOffset(offset)
        let floatIndex = (offset)/(itemWidth + itemPadding)
        
        var index = Int(round(floatIndex))
        if max(index, 0) > itemsAmount {
            index = itemsAmount
        }
        
        return min(max(index, 0), itemsAmount - 1)
    }
    
    // 03
    private func countCurrentScrollOffset() -> CGFloat {
        return countOffset(for: currentPageIndex) + gestureDragOffset
    }

    // 04
    private func countLogicalOffset(_ trueOffset: CGFloat) -> CGFloat {
        return (trueOffset-leadingOffset) * -1.0
    }

    var body: some View {
        // 01
        GeometryReader { viewGeometry in
            HStack(alignment: .center, spacing: itemSpacing) {
                ForEach(items.indices, id: \.self) { itemIndex in
                    items[itemIndex].frame(width: itemWidth)
                }
            }
        }
        .onAppear { // 02
            currentScrollOffset = countOffset(for: currentPageIndex)
        }
        .background(Color.black.opacity(0.00001)) // hack - this allows gesture recognizing even when background is transparent
        .frame(width: contentWidth)
        .offset(x: self.currentScrollOffset, y: 0)
        .simultaneousGesture( // 03
            DragGesture(minimumDistance: 1, coordinateSpace: .local)
                .onChanged { value in // 04
                    gestureDragOffset = value.translation.width
                    currentScrollOffset = countCurrentScrollOffset()
                }
                .onEnded { value in // 05
                    let cleanOffset = (value.predictedEndTranslation.width - gestureDragOffset)
                    let velocityDiff = cleanOffset * scrollDampingFactor
                    
                    var newPageIndex = countPageIndex(for: currentScrollOffset + velocityDiff)
                    
                    let currentItemOffset = CGFloat(currentPageIndex) * (itemWidth + itemPadding)
                    
                    if currentScrollOffset < -(currentItemOffset),
                       newPageIndex == currentPageIndex {
                        newPageIndex += 1
                    }
                    
                    gestureDragOffset = 0
                    // 06
                    withAnimation(.interpolatingSpring(mass: 0.1,
                                                       stiffness: 20,
                                                       damping: 1.5,
                                                       initialVelocity: 0)) {
                        self.currentPageIndex = newPageIndex
                        self.currentScrollOffset = self.countCurrentScrollOffset()
                    }
                }
        )
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}

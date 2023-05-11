//
//  CardView.swift
//  TinderCardSwiperSwiftUI_Example
//
//  Created by MacBook Pro on 28/02/23.
//


import SwiftUI

@available(iOS 13.0, *)
@available(macOS 10.15, *)
@available(tvOS 13.0, *)
@available(watchOS 6.0, *)

public struct CardSwipeView<Content: View>: View {
    
    // MARK: - Properties
    
    @State public var offset = CGSize.zero
    @State public var color: Color = .clear
    @State public var isRemoved = false
    public var onCardRemoved: (() -> Void)?
    public var onCardAdded: (() -> Void)?
    public var content: () -> Content
    
    // MARK: - Initializer
    
    public init(onCardRemoved: (() -> Void)? = nil, onCardAdded: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.onCardRemoved = onCardRemoved
        self.onCardAdded = onCardAdded
        self.content = content
    }
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            content()
                .frame(width: 320, height: 420)
            Rectangle()
                .foregroundColor(color.opacity(0.5)) // adjust opacity as needed
            
                .cornerRadius(10)
                .frame(width: 380,height: 600)
            
        }
        .offset(x: offset.width * 1, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        updateCardColor(width: offset.width)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        handleSwipe(width: offset.width)
                        updateCardColor(width: offset.width)
                    }
                }
        )
        .opacity(isRemoved ? 0 : 1) // add this modifier to handle card removal
    }
    
    // MARK: - Methods
    
    public func handleSwipe(width: CGFloat) {
        switch width {
        case -500...(-150):
            onCardRemoved?()
            offset = CGSize(width: -500, height: 0)
            isRemoved = true // set isRemoved to true
        case 150...500:
            onCardAdded?()
            offset = CGSize(width: 500, height: 0)
            isRemoved = true // set isRemoved to true
        default:
            offset = .zero
        }
    }
    
    
    public func updateCardColor(width: CGFloat) {
        switch width {
        case -500...(-10):
            color = .red
        case 10...500:
            color = .green
        default:
            color = .clear
            
            
        }
    }
}


public typealias CardActionClosure = (String) -> Void


public struct CardStackView<Content: View>: View {
    
    public typealias CardActionClosure = () -> Void
    
    @State private var currentIndex: Int = 0
    public let cards: [CardSwipeView<Content>]
    public let cardAction: CardActionClosure
    public var loopCards: Bool = false
    
    public init(cards: [CardSwipeView<Content>], cardAction: @escaping CardActionClosure, loopCards: Bool = false) {
        self.cards = cards
        self.cardAction = cardAction
        self.loopCards = loopCards
    }
    
    public var body: some View {
        ZStack {
            ForEach(cards.indices.reversed(), id: \.self) { index in
                let card = cards[index]
                if index == currentIndex {
                    currentCardView(card: card)
                        .overlay(GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    let screen = UIScreen.main.bounds
                                    let rect = geometry.frame(in: .global)
                                    if rect.maxY < screen.midY {
                                        currentIndex += 1
                                        cardAction()
                                        if loopCards && currentIndex == cards.count {
                                            currentIndex = 0
                                        }
                                        // Align the next card automatically
                                        if currentIndex < cards.count {
                                            cards[currentIndex].offset = .zero
                                        }
                                    }
                                }
                        })
                } else if index > currentIndex {
                    upcomingCardView(card: card, index: index)
                } else {
                    pastCardView(card: card, index: index)
                }
            }
        }
        .padding(.horizontal, 20.0)
        .onAppear {
            if currentIndex >= cards.count {
                currentIndex = loopCards ? 0 : cards.count - 1
            }
            while currentIndex < cards.count && cards[currentIndex].isRemoved {
                currentIndex += 1
            }
            // Align the first card automatically
            if currentIndex < cards.count {
                cards[currentIndex].offset = .zero
            }
        }
    }
    
    private func currentCardView(card: CardSwipeView<Content>) -> some View {
        card
            .animation(.spring())
            .zIndex(Double(cards.count))
            .offset(x: 0, y: 0)
            .rotationEffect(.degrees(Double((currentIndex == 0 ? 0 : currentIndex - 1) * 2)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        card.offset = gesture.translation
                    }
                    .onEnded { _ in
                        withAnimation {
                            card.handleSwipe(width: card.offset.width)
                            if abs(card.offset.width) > 100 {
                                currentIndex += 1
                                cardAction()
                                if loopCards && currentIndex == cards.count {
                                    currentIndex = 0
                                }
                                // Align the next card automatically
                                if currentIndex < cards.count {
                                    cards[currentIndex].offset = .zero
                                }
                            }
                            card.offset = .zero
                        }
                    }
            )
    }
    
    private func upcomingCardView(card: CardSwipeView<Content>, index: Int) -> some View {
        let isRemoving = currentIndex > index
        let yOffset = isRemoving ? 10 : 10 + CGFloat(index - currentIndex) * 10
        return withAnimation(.spring()) {
            card
                .zIndex(Double(cards.count - index))
            // .offset(x: 0, y: yOffset)
            //.rotationEffect(.degrees(Double((currentIndex - index) * 2)))
        }
    }
    
    private func pastCardView(card: CardSwipeView<Content>, index: Int) -> some View {
        let offset = 10 + CGFloat(index - currentIndex) * 10
        return card
            .zIndex(Double(index))
            .offset(x: 0, y: offset)
            .rotationEffect(.degrees(Double((index - currentIndex) * 2)))
            .opacity(0)
        .animation(.spring(), value: currentIndex)    }
}

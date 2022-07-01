//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/22.
//

import CoreMotion
import SpriteKit
import SwiftUI

class GameScene: SKScene { //An object that organizes all of the active SpriteKit content.
    //MARK: - Properties
    let gameManager = GameManager.shared
    var velocityDelegate: ContentView?
    let testNode = SpinnerNode()
    let afterImageNodes: [SKSpriteNode] = {
        var nodes: [SKSpriteNode] = []
        for i in [1, 2, 4, 8] {
            let node = SpinnerNode()
            node.alpha = 0.1
            let bitMask = UInt32(i)
            print("DEBUG: bitmask - \(bitMask)")
            node.physicsBody?.collisionBitMask = bitMask
            node.physicsBody?.contactTestBitMask = bitMask
            node.physicsBody?.categoryBitMask = bitMask
            nodes.append(node)
            print("DEBUG: nodes count - \(nodes.count)")
        }
        return nodes
    }()

    //MARK: - Initializer
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - LifeCycle
    override func update(_ currentTime: TimeInterval) {
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        velocityDelegate?.velocityChanged(velocity: Double(testNode.physicsBody!.angularVelocity))
    }
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -100, right: 0)))
        physicsWorld.contactDelegate = self
        backgroundColor = .white
        testNode.position = CGPoint(x: frame.midX, y: frame.midY)
        testNode.physicsBody?.collisionBitMask = 0
        testNode.physicsBody?.contactTestBitMask = 0
        testNode.physicsBody?.categoryBitMask = 0
        self.addChild(testNode)
  
        for node in afterImageNodes {
            node.position = CGPoint(x: frame.midX, y: frame.midY)
            self.addChild(node)
        }
        let panGestureRecognizer : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(GameScene.didSwipe))
        view.addGestureRecognizer(panGestureRecognizer)
    }
}

//MARK: - Delegates
extension GameScene {
    @objc func didSwipe(sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: self.view)
        print("DEBUG: swipe gesture x : \(velocity.x)")
        let testAnimation = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 100000, duration: 0.1)])
        let subAnimation = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 100000, duration: 0.12)])
        let subAnimation2 = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 100000, duration: 0.18)])
        let subAnimation3 = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 100000, duration: 0.24)])
        let subAnimation4 = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 100000, duration: 0.3)])
        
        let afterImageEffects = [subAnimation, subAnimation2, subAnimation3, subAnimation4]
        for i in 0...3 {
            afterImageNodes[i].run(afterImageEffects[i])
        }
        testNode.run(testAnimation)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //접촉이 시작되었을 때 해당 메서드 실행됨

    }
}

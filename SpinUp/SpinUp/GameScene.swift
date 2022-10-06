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
    var gameManager = GameManager.shared
    private let testNode = SpinnerNode()
    private var gestureRecognizer: UIPanGestureRecognizer?
    private var isSpinning: Bool = false
    

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
        //        velocityDelegate?.velocityChanged(velocity: Double(testNode.physicsBody!.angularVelocity))
        
        print(testNode.physicsBody?.angularVelocity)
        if testNode.physicsBody?.angularVelocity ?? 5 < 3 && isSpinning == true && gameManager.state == .running {
            gameManager.state = .stop
            
        }
    }
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -100, right: 0)))
        physicsWorld.contactDelegate = self
        backgroundColor = .white
        testNode.position = CGPoint(x: frame.midX, y: frame.midY)
        testNode.physicsBody?.collisionBitMask = 0
        testNode.physicsBody?.contactTestBitMask = 0
        testNode.physicsBody?.categoryBitMask = 0
        testNode.physicsBody?.friction = 1000
        self.addChild(testNode)
  
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(GameScene.didSwipe))
        view.addGestureRecognizer(gestureRecognizer!)
    }
}

//MARK: - Delegates
extension GameScene {
    @objc func didSwipe(sender: UIPanGestureRecognizer) {
        guard gameManager.state == .running else { return }
        let velocity = sender.velocity(in: self.view)
        print("DEBUG: swipe gesture x : \(velocity.x)")
        let testAnimation = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 1000, duration: 0.1)])
        testNode.run(testAnimation)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isSpinning = true
        }
        
        if let gestureRecognizer {
            view?.removeGestureRecognizer(gestureRecognizer)
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //접촉이 시작되었을 때 해당 메서드 실행됨

    }
}

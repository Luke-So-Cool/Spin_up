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
    private var spinnerID: Int = 0
    

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
        

        if gameManager.currentSpinnerID != spinnerID {
            changeFidget(id: gameManager.currentSpinnerID)
        }
        if testNode.physicsBody?.angularVelocity ?? 5 < 10 && isSpinning == true && gameManager.state == .running {
            stopFidget()
        }
    }
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -100, right: 0)))
        physicsWorld.contactDelegate = self
//        backgroundColor = .red
        testNode.position = CGPoint(x: frame.midX, y: frame.midY)
        testNode.physicsBody?.collisionBitMask = 0
        testNode.physicsBody?.contactTestBitMask = 0
        testNode.physicsBody?.categoryBitMask = 0
        testNode.physicsBody?.friction = 1000
        self.addChild(testNode)
        
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(GameScene.didSwipe))
        enableGestureRecognizer()
    }
    
    //MARK: - Helpers
    
    func enableGestureRecognizer() {
        print("DEBUG: 제스쳐 활성화")
        if let gestureRecognizer {
            view?.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    func disableGestureRecognizer() {
        print("DEBUG: 제스쳐 비활성화")
        if let gestureRecognizer {
            view?.removeGestureRecognizer(gestureRecognizer)
        }
    }
    
    func stopFidget() {
        print("DEBUG: 피젯 감속")
        testNode.physicsBody?.angularVelocity -= 0.05
        if testNode.physicsBody!.angularVelocity < 0.3 {
            testNode.physicsBody?.angularVelocity = 0
            isSpinning = false
            print("DEBUG: 피젯 정지")
            gameManager.state = .stop
        }
    }
    
    func spinFidget(velocity: CGPoint) {
        if isSpinning == false {
            let testAnimation = SKAction.sequence([SKAction.applyAngularImpulse(velocity.x / 1000, duration: 0.1)])
            testNode.run(testAnimation)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.isSpinning = true
            }
            
            print("DEBUG: 회전중...")
        }
    }
    
    func changeFidget(id: Int) {
        testNode.texture = SKTexture(imageNamed: "SPN\(id)")
        self.spinnerID = id
        print("DEBUG: 스피너 변경됨 ID - \(id)")
    }
}

//MARK: - Delegates
extension GameScene {
    @objc func didSwipe(sender: UIPanGestureRecognizer) {
        guard gameManager.state == .running else { return }
        
        let velocity = sender.velocity(in: self.view)
        print("DEBUG: Swiped \(velocity.x)")
        spinFidget(velocity: velocity)
        disableGestureRecognizer()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        //접촉이 시작되었을 때 해당 메서드 실행됨

    }
}

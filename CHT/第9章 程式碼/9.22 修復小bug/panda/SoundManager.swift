import SpriteKit
//引入多媒體框架
import AVFoundation

class SoundManager :SKNode{
    //申明一個播放器
    var bgMusicPlayer = AVAudioPlayer()
    //播放起跳音效的動作
    let jumpAct = SKAction.playSoundFileNamed("jump_from_platform.mp3", waitForCompletion: false)
    //播放game over音效的動作
    let loseAct = SKAction.playSoundFileNamed("lose.mp3", waitForCompletion: false)
    //播放卷動音效的動作
    let rollAct = SKAction.playSoundFileNamed("hit_platform.mp3", waitForCompletion: false)
    //播放吃蘋果音效的動作
    let eatAct = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
    
    //播放背景音樂的音效
    func playBackGround(){
        //取得apple.mp3檔案位址
        let bgMusicURL:NSURL =  NSBundle.mainBundle().URLForResource("apple", withExtension: "mp3")!
        //根據背景音樂位址產生播放器
        bgMusicPlayer=try! AVAudioPlayer(contentsOfURL: bgMusicURL)
        //設定為循環播放
        bgMusicPlayer.numberOfLoops = -1
        //準備播放音樂
        bgMusicPlayer.prepareToPlay()
        //播放音樂
        bgMusicPlayer.play()
    }
    //播放game over 音效動作的方法
    func playDead(){
        self.runAction(loseAct)
    }
    //播放起跳音效動作的方法
    func playJump(){
        self.runAction(jumpAct)
    }
    //播放打滾音效動作的方法
    func playRoll(){
        self.runAction(rollAct)
    }
    //播放吃蘋果音效動作的方法
    func playEat(){
        self.runAction(eatAct)
    }
    
}
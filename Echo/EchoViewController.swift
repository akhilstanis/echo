//
//  EchoViewController.swift
//  Echo
//
//  Created by Akhil Stanislavose on 08/10/15.
//  Copyright (c) 2015 Akhil Stanislavose. All rights reserved.
//

import Cocoa

class EchoViewController: NSViewController  {

    @IBOutlet weak var contentTextField: NSTextField!
    @IBOutlet weak var voicesPopupButton: NSPopUpButton!

    var voice = "Agnes"

    let sayOptions = [
        "Agnes - Isn't it nice to have a computer that will talk to you?",
        "Albert -  I have a frog in my throat. No, I mean a real frog!",
        "Alex - Most people recognize me by my voice.",
        "Alice - Salve, mi chiamo Alice e sono una voce italiana.",
        "Alva - Hej, jag heter Alva. Jag är en svensk röst.",
        "Amelie - Bonjour, je m’appelle Amelie. Je suis une voix canadienne.",
        "Anna - Hallo, ich heiße Anna und ich bin eine deutsche Stimme.",
        "Bad News - The light you see at the end of the tunnel is the headlamp of a fast approaching train.",
        "Bahh - Do not pull the wool over my eyes.",
        "Bells - Time flies when you are having fun.",
        "Boing - Spring has sprung, fall has fell, winter's here and it's colder than usual.",
        "Bruce - I sure like being inside this fancy computer",
        "Bubbles - Pull the plug! I'm drowning!",
        "Carmit - שלום. קוראים לי כרמית, ואני קול בשפה העברית.",
        "Cellos - Doo da doo da dum dee dee doodly doo dum dum dum doo da doo da doo da doo da doo da doo da doo",
        "Damayanti - Halo, nama saya Damayanti. Saya berbahasa Indonesia.",
        "Daniel - Hello, my name is Daniel. I am a British-English voice.",
        "Deranged - I need to go on a really long vacation.",
        "Diego - Hola, me llamo Diego y soy una voz española.",
        "Ellen - Hallo, mijn naam is Ellen. Ik ben een Belgische stem.",
        "Fiona - Hello, my name is Fiona. I am a Scottish-English voice.",
        "Fred - I sure like being inside this fancy computer",
        "Good News - Congratulations you just won the sweepstakes and you don't have to pay income tax again.",
        "Hysterical - Please stop tickling me!",
        "Ioana - Bună, mă cheamă Ioana . Sunt o voce românească.",
        "Joana - Olá, chamo-me Joana e dou voz ao português falado em Portugal.",
        "Junior - My favorite food is pizza.",
        "Kanya - สวัสดีค่ะ ดิฉันชื่อKanya",
        "Karen - Hello, my name is Karen. I am an Australian-English voice.",
        "Kathy - Isn't it nice to have a computer that will talk to you?",
        "Kyoko - こんにちは、私の名前はKyokoです。日本語の音声をお届けします。",
        "Laura - Ahoj. Volám sa Laura . Som hlas v slovenskom jazyku.",
        "Lekha - नमस्कार, मेरा नाम लेखा है.Lekha[[FEMALE_NAME]]मै हिंदी मे बोलने वाली आवाज़ हूँ.",
        "Luciana - Olá, o meu nome é Luciana e a minha voz corresponde ao português que é falado no Brasil",
        "Mariska - Üdvözlöm! Mariska vagyok. Én vagyok a magyar hang.",
        "Mei-Jia - 您好，我叫美佳。我說國語。",
        "Melina - Γεια σας, ονομάζομαι Melina. Είμαι μια ελληνική φωνή.",
        "Milena - Здравствуйте, меня зовут Milena. Я – русский голос системы.",
        "Moira - Hello, my name is Moira. I am an Irish-English voice.",
        "Monica - Hola, me llamo Monica y soy una voz española.",
        "Nora - Hei, jeg heter Nora. Jeg er en norsk stemme.",
        "Paulina - Hola, me llamo Paulina y soy una voz mexicana.",
        "Pipe Organ - We must rejoice in this morbid voice.",
        "Princess - When I grow up I'm going to be a scientist.",
        "Ralph - The sum of the squares of the legs of a right triangle is equal to the square of the hypotenuse.",
        "Samantha - Hello, my name is Samantha. I am an American-English voice.",
        "Sara - Hej, jeg hedder Sara. Jeg er en dansk stemme.",
        "Satu - Hei, minun nimeni on Satu. Olen suomalainen ääni.",
        "Sin-ji - 您好，我叫 Sin-ji。我講廣東話。",
        "Tarik - مرحبًا اسمي Tarik. أنا عربي من السعودية.",
        "Tessa - Hello, my name is Tessa. I am a South African-English voice.",
        "Thomas - Bonjour, je m’appelle Thomas. Je suis une voix française.",
        "Ting-Ting - 您好，我叫Ting-Ting。我讲中文普通话。",
        "Trinoids - We cannot communicate with these carbon units.",
        "Veena - Hello, my name is Veena. I am an Indian-English voice.",
        "Vicki - Isn't it nice to have a computer that will talk to you?",
        "Victoria - Isn't it nice to have a computer that will talk to you?",
        "Whisper - Pssssst, hey you, Yeah you, Who do ya think I'm talking to, the mouse?",
        "Xander - Hallo, mijn naam is Xander. Ik ben een Nederlandse stem.",
        "Yelda - Merhaba, benim adım Yelda. Ben Türkçe bir sesim.",
        "Yuna - 안녕하세요. 제 이름은 Yuna입니다. 저는 한국어 음성입니다.",
        "Zarvox - That looks like a peaceful planet.",
        "Zosia - Witaj. Mam na imię Zosia, jestem głosem kobiecym dla języka polskiego.",
        "Zuzana - Dobrý den, jmenuji se Zuzana. Jsem český hlas."
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        voicesPopupButton.addItemsWithTitles(sayOptions)
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        contentTextField.becomeFirstResponder()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        contentTextField.stringValue = ""
    }

    override func cancelOperation(sender: AnyObject?) {
        NSNotificationCenter.defaultCenter().postNotificationName("closePopover", object: nil)
    }

    @IBAction func textEntered(sender: AnyObject) {
        say(contentTextField.stringValue)
    }

    func say(text: NSString) {
        if text == "" {
            return
        }

        let task = NSTask()
        task.launchPath = "/usr/bin/say"
        task.arguments = ["-v\(voice)", text]
        task.launch()
    }

    @IBAction func settingButtonClicked(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("toggleSettings", object: nil)
    }

    @IBAction func voiceSelected(sender: AnyObject) {
        let fullVoice = voicesPopupButton.selectedItem?.title
        if let v = fullVoice?.componentsSeparatedByString(" - ").first {
            voice = v
        }
    }
}


struct PastTenseConverter {
    
    // Dictionary with common verbs (especially health-related)
    private static let verbMap: [String: String] = [
        // Common health verbs
        "take": "took",
        "start": "started",
        "stop": "stopped",
        "begin": "began",
        "end": "ended",
        "finish": "finished",
        "exercise": "exercised",
        "walk": "walked",
        "run": "ran",
        "jog": "jogged",
        "swim": "swam",
        "bike": "biked",
        "cycle": "cycled",
        "lift": "lifted",
        "eat": "ate",
        "drink": "drank",
        "rest": "rested",
        "relax": "relaxed",
        "visit": "visited",
        "meet": "met",
        "call": "called",
        "contact": "contacted",
        "schedule": "scheduled",
        "book": "booked",
        "cancel": "canceled",
        "postpone": "postponed",
        "switch": "switched",
        "increase": "increased",
        "decrease": "decreased",
        "reduce": "reduced",
        "add": "added",
        "remove": "removed",
        "try": "tried",
        "attempt": "attempted",
        "work": "worked",
        "practice": "practiced",
        "meditate": "meditated",
        "breathe": "breathed",
        "focus": "focused",
        "concentrate": "concentrated",
        "track": "tracked",
        "monitor": "monitored",
        "record": "recorded",
        "log": "logged",
        "note": "noted",
        "write": "wrote",
        "read": "read",
        "study": "studied",
        "learn": "learned",
        "teach": "taught",
        "show": "showed",
        "watch": "watched",
        "listen": "listened",
        "hear": "heard",
        "think": "thought",
        "believe": "believed",
        "know": "knew",
        "check": "checked",
        "test": "tested",
        "measure": "measured",
        "weigh": "weighed",
        "count": "counted",
        "calculate": "calculated",
        "plan": "planned",
        "prepare": "prepared",
        "organize": "organized",
        "arrange": "arranged",
        "set": "set",
        "adjust": "adjusted",
        "improve": "improved",
        "enhance": "enhanced",
        "build": "built",
        "make": "made",
        "do": "did",
        "perform": "performed",
        "complete": "completed",
        "accomplish": "accomplished",
        "achieve": "achieved",
        "reach": "reached",
        "attain": "attained",
        "obtain": "obtained",
        "accept": "accepted",
        "reject": "rejected",
        "refuse": "refused",
        "avoid": "avoided",
        "prevent": "prevented",
        "protect": "protected",
        "resume": "resumed",
        "pause": "paused",
        "break": "broke",
        "interrupt": "interrupted",
        "come": "came",
        "arrive": "arrived",
        "leave": "left",
        "depart": "departed",
        "return": "returned",
        "travel": "traveled",
        "move": "moved",
        "sit": "sat",
        "stand": "stood",
        "lie": "lay",
        "sleep": "slept",
        "wake": "woke",
        "rise": "rose",
        "fall": "fell",
        "drop": "dropped",
        "search": "searched",
        "seek": "sought",
        "ask": "asked",
        "question": "questioned",
        "answer": "answered",
        "reply": "replied",
        "respond": "responded",
        "tell": "told",
        "say": "said",
        "speak": "spoke",
        "talk": "talked",
        "discuss": "discussed",
        "explain": "explained",
        "describe": "described",
        "express": "expressed",
        "communicate": "communicated",
        "give": "gave",
        "provide": "provided",
        "offer": "offered",
        "present": "presented",
        "deliver": "delivered",
        "send": "sent",
        "receive": "received",
        "bring": "brought",
        "carry": "carried",
        "grab": "grabbed",
        "catch": "caught",
        "throw": "threw",
        "push": "pushed",
        "pull": "pulled",
        "press": "pressed",
        "squeeze": "squeezed",
        "handle": "handled",
        "manage": "managed",
        "control": "controlled",
        "guide": "guided",
        "direct": "directed",
        "follow": "followed",
        "join": "joined",
        "participate": "participated",
        "engage": "engaged",
        "exclude": "excluded",
        "motivate": "motivated",
        "inspire": "inspired",
        "influence": "influenced",
        "affect": "affected",
        "impact": "impacted",
        "cause": "caused",
        "result": "resulted",
        "lead": "led",
        "produce": "produced",
        "generate": "generated",
        "create": "created",
        "form": "formed",
        "develop": "developed",
        "grow": "grew",
        "expand": "expanded",
        "extend": "extended",
        "stretch": "stretched",
        "spread": "spread",
        "distribute": "distributed",
        "share": "shared",
        "divide": "divided",
        "separate": "separated",
        "combine": "combined",
        "connect": "connected",
        "link": "linked",
        "relate": "related",
        "associate": "associated",
        "compare": "compared",
        "contrast": "contrasted",
        "differ": "differed",
        "vary": "varied",
        "change": "changed",
        "modify": "modified",
        "alter": "altered",
        "transform": "transformed",
        "convert": "converted",
        "turn": "turned",
        "remain": "remained",
        "stay": "stayed",
        "maintain": "maintained",
        "preserve": "preserved",
        "save": "saved",
        "store": "stored",
        "keep": "kept",
        "hold": "held",
        "contain": "contained",
        "include": "included",
        "consist": "consisted",
        "comprise": "comprised",
        "involve": "involved",
        "require": "required",
        "need": "needed",
        "want": "wanted",
        "desire": "desired",
        "wish": "wished",
        "hope": "hoped",
        "expect": "expected",
        "anticipate": "anticipated",
        "predict": "predicted",
        "forecast": "forecasted",
        "estimate": "estimated",
        "guess": "guessed",
        "assume": "assumed",
        "suppose": "supposed",
        "imagine": "imagined",
        "visualize": "visualized",
        "picture": "pictured",
        "see": "saw",
        "view": "viewed",
        "observe": "observed",
        "witness": "witnessed",
        "notice": "noticed",
        "spot": "spotted",
        "detect": "detected",
        "discover": "discovered",
        "find": "found",
        "locate": "located",
        "identify": "identified",
        "recognize": "recognized",
        "realize": "realized",
        "understand": "understood",
        "comprehend": "comprehended",
        "grasp": "grasped",
        "appreciate": "appreciated",
        "value": "valued",
        "respect": "respected",
        "admire": "admired",
        "love": "loved",
        "like": "liked",
        "enjoy": "enjoyed",
        "prefer": "preferred",
        "favor": "favored",
        "choose": "chose",
        "pick": "picked",
        "select": "selected",
        "opt": "opted",
        "decide": "decided",
        "determine": "determined",
        "resolve": "resolved",
        "settle": "settled",
        "solve": "solved",
        "fix": "fixed",
        "repair": "repaired",
        "mend": "mended",
        "heal": "healed",
        "cure": "cured",
        "treat": "treated",
        "care": "cared",
        "tend": "tended",
        "nurse": "nursed",
        "help": "helped",
        "assist": "assisted",
        "aid": "aided",
        "support": "supported",
        "back": "backed",
        "encourage": "encouraged",
        "promote": "promoted",
        "advance": "advanced",
        "progress": "progressed",
        "proceed": "proceeded",
        "continue": "continued",
        "persist": "persisted",
        "endure": "endured",
        "last": "lasted",
        "survive": "survived",
        "live": "lived",
        "exist": "existed",
        "be": "was/were",
        "have": "had",
        "get": "got",
        "become": "became",
        "seem": "seemed",
        "appear": "appeared",
        "look": "looked",
        "sound": "sounded",
        "feel": "felt",
        "taste": "tasted",
        "smell": "smelled",
        "touch": "touched",
        "going": "went",
        "go": "went",

    ]
    
    // Special cases (activities that aren't verbs)
    private static let specialCases: [String: String] = [
        "yoga": "did yoga",
        "meditation": "did meditation",
        "pilates": "did pilates",
        "therapy": "went to therapy",
        "counseling": "went to counseling",
        "massage": "got a massage",
        "acupuncture": "had acupuncture",
        "physical therapy": "did physical therapy",
        "physiotherapy": "did physiotherapy",
        "chiropractic": "went to chiropractic",
        "dentist": "went to the dentist",
        "doctor": "went to the doctor",
        "hospital": "went to the hospital",
        "clinic": "went to the clinic",
        "appointment": "had an appointment",
        "checkup": "had a checkup",
        "examination": "had an examination",
        "test": "had a test",
        "screening": "had a screening",
        "scan": "had a scan",
        "x-ray": "had an x-ray",
        "mri": "had an MRI",
        "ct scan": "had a CT scan",
        "ultrasound": "had an ultrasound",
        "blood work": "had blood work done",
        "lab work": "had lab work done",
        "surgery": "had surgery",
        "procedure": "had a procedure",
        "treatment": "received treatment",
        "injection": "received an injection",
        "vaccination": "received a vaccination",
        "immunization": "received an immunization",
        "flu shot": "got a flu shot",
        "shopping": "went shopping",
        "shop": "went shopping"

    ]
    
    // Words that are already past tense
    private static let pastTenseWords = Set([
        "walked", "watched", "started", "stopped", "exercised", "visited",
        "called", "scheduled", "changed", "tried", "helped", "worked",
        "rested", "relaxed", "stretched", "biked", "lifted", "went",
        "came", "took", "ate", "drank", "slept", "ran", "swam", "saw",
        "got", "did", "had", "felt", "made", "said", "told", "gave",
        "brought", "thought", "knew", "found", "left", "kept", "held",
        "met", "heard", "became", "seemed", "looked", "turned", "moved",
        "lived", "died", "sat", "stood", "lay", "fell", "rose", "wore",
        "drove", "rode", "flew", "drew", "wrote", "read", "spoke", "broke",
        "chose", "won", "lost", "built", "bought", "sold", "paid", "spent",
        "sent", "lent", "bent", "cut", "hit", "hurt", "put", "shut", "let",
        "set", "bet", "cost", "burst", "cast", "fit", "quit", "split",
        "spread", "shed", "fed", "led", "bled", "bred", "fled", "sped",
        "slid", "hid", "bid", "rid", "forbid", "outdid", "undid", "redid"
    ])
    
    static func convertToPast(_ input: String) -> String {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return input }
        
        let words = trimmed.components(separatedBy: .whitespaces)
        
        guard let firstWord = words.first?.lowercased() else {
            return input
        }
        
        // Check if already past tense
        if pastTenseWords.contains(firstWord) {
            return input
        }
        
        // Check dictionary first
        if let pastTense = verbMap[firstWord] {
            var result = [pastTense]
            result.append(contentsOf: words.dropFirst())
            return result.joined(separator: " ")
        }
        
        // Check special cases
        let fullPhrase = trimmed.lowercased()
        if let special = specialCases[fullPhrase] {
            return special
        }
        
        // Check if first word is in special cases
        if let special = specialCases[firstWord] {
            var result = [special]
            result.append(contentsOf: words.dropFirst())
            return result.joined(separator: " ")
        }
        
        // Apply simple rules to first word only
        let pastFirstWord = addEdEnding(to: firstWord)
        var result = [pastFirstWord]
        result.append(contentsOf: words.dropFirst())
        return result.joined(separator: " ")
    }
    
    private static func addEdEnding(to word: String) -> String {
        // Don't modify very short words or words that might not be verbs
        guard word.count > 2 else { return word + "ed" }
        
        // Simple rules
        if word.hasSuffix("e") {
            return word + "d"
        } else if word.hasSuffix("y") && word.count > 1 {
            let beforeY = word[word.index(word.endIndex, offsetBy: -2)]
            if !"aeiou".contains(beforeY) {
                return String(word.dropLast()) + "ied"
            } else {
                return word + "ed"
            }
        } else if shouldDoubleConsonant(word) {
            return word + String(word.last!) + "ed"
        } else {
            return word + "ed"
        }
    }
    
    private static func shouldDoubleConsonant(_ word: String) -> Bool {
        guard word.count >= 3 else { return false }
        
        let chars = Array(word)
        let vowels = "aeiou"
        let consonants = "bcdfghjklmnpqrstvwxz"
        
        // Check for CVC pattern (consonant-vowel-consonant) ending
        let thirdLast = chars[chars.count - 3]
        let secondLast = chars[chars.count - 2]
        let last = chars[chars.count - 1]
        
        // Must be consonant-vowel-consonant pattern
        guard consonants.contains(thirdLast) &&
              vowels.contains(secondLast) &&
              consonants.contains(last) else {
            return false
        }
        
        // Don't double w, x, y
        guard !"wxy".contains(last) else {
            return false
        }
        
        // Don't double if word ends in double consonant already
        if chars.count >= 2 && chars[chars.count - 2] == last {
            return false
        }
        
        return true
    }
}

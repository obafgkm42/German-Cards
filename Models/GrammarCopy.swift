import Foundation

struct GrammarCopy {
    let language: GrammarLanguage

    var navigationTitle: String { value("語法", "语法", "Grammar") }

    var foundationsChapterTitle: String { value("名詞與格", "名词与格", "Nouns & cases") }
    var foundationsChapterLevel: String { "A1–A2" }
    var foundationsChapterDetail: String { value("先掌握冠詞、四格和代詞，句子的骨架就會清楚很多。", "先掌握冠词、四格和代词，句子的骨架就会清楚很多。", "Articles, cases, and pronouns form the framework of most German sentences.") }
    var sentencesChapterTitle: String { value("句型與語序", "句型与语序", "Sentences & word order") }
    var sentencesChapterLevel: String { "A1–B1" }
    var sentencesChapterDetail: String { value("德語語序的核心是變位動詞的位置。", "德语语序的核心是变位动词的位置。", "German word order is organized around the position of the finite verb.") }
    var verbsChapterTitle: String { value("動詞系統", "动词系统", "Verb system") }
    var verbsChapterLevel: String { "A2–B1" }
    var verbsChapterDetail: String { value("把助動詞、分詞和可分前綴當成一個句框來理解。", "把助动词、分词和可分前缀当成一个句框来理解。", "Think of auxiliaries, participles, and separable prefixes as a sentence bracket.") }
    var modifiersChapterTitle: String { value("修飾語與介詞", "修饰语与介词", "Modifiers & prepositions") }
    var modifiersChapterLevel: String { "A2–B1" }
    var modifiersChapterDetail: String { value("詞尾和介詞會透露名詞在句子裡扮演的角色。", "词尾和介词会透露名词在句子里扮演的角色。", "Endings and prepositions reveal the role a noun plays in the sentence.") }
    var advancedChapterTitle: String { value("進階表達", "进阶表达", "Advanced structures") }
    var advancedChapterLevel: String { "B2–C1" }
    var advancedChapterDetail: String { value("在長句、正式寫作與轉述中，同時控制格、語序和語氣。", "在长句、正式写作与转述中，同时控制格、语序和语气。", "Control case, word order, and stance in longer sentences, formal writing, and reported speech.") }

    var articlesTitle: String { value("定冠詞 der / die / das", "定冠词 der / die / das", "Definite articles") }
    var caseLabel: String { value("格", "格", "Case") }
    var masc: String { value("陽性", "阳性", "Masc") }
    var fem: String { value("陰性", "阴性", "Fem") }
    var neut: String { value("中性", "中性", "Neut") }
    var plural: String { value("複數", "复数", "Plural") }

    var caseRolesTitle: String { value("四格的工作", "四格的工作", "What the four cases do") }
    var nominativeRoleTitle: String { value("Nominativ：誰做？", "Nominativ：谁做？", "Nominative: who acts?") }
    var nominativeRoleDetail: String { value("主語與表語：Der Hund ist freundlich.", "主语与表语：Der Hund ist freundlich.", "The subject and predicate noun: Der Hund ist freundlich.") }
    var accusativeRoleTitle: String { value("Akkusativ：直接影響誰？", "Akkusativ：直接影响谁？", "Accusative: directly affected?") }
    var accusativeRoleDetail: String { value("直接受詞：Ich sehe den Hund.", "直接宾语：Ich sehe den Hund.", "The direct object: Ich sehe den Hund.") }
    var dativeRoleTitle: String { value("Dativ：給誰／對誰？", "Dativ：给谁／对谁？", "Dative: to or for whom?") }
    var dativeRoleDetail: String { value("間接受詞：Ich gebe dem Kind das Buch.", "间接宾语：Ich gebe dem Kind das Buch.", "The indirect object: Ich gebe dem Kind das Buch.") }
    var genitiveRoleTitle: String { value("Genitiv：屬於誰？", "Genitiv：属于谁？", "Genitive: whose?") }
    var genitiveRoleDetail: String { value("所有關係：das Auto des Lehrers；口語常改用 von + Dativ。", "所有关系：das Auto des Lehrers；口语常改用 von + Dativ。", "Possession: das Auto des Lehrers; speech often uses von + dative.") }

    var pronounsTitle: String { value("人稱代詞速查", "人称代词速查", "Personal pronouns") }
    var nominativePronouns: String { "ich · du · er/sie/es · wir · ihr · sie/Sie" }
    var accusativePronouns: String { "mich · dich · ihn/sie/es · uns · euch · sie/Sie" }
    var dativePronouns: String { "mir · dir · ihm/ihr/ihm · uns · euch · ihnen/Ihnen" }
    var pronounNoteTitle: String { value("sie 還是 Sie？", "sie 还是 Sie？", "sie or Sie?") }
    var pronounNoteDetail: String { value("小寫 sie 可指「她／他們」；大寫 Sie 是正式的「您／你們」。", "小写 sie 可指“她／他们”；大写 Sie 是正式的“您／你们”。", "Lowercase sie means “she” or “they”; capitalized Sie is the formal “you.”") }

    var pluralTitle: String { value("名詞複數", "名词复数", "Noun plurals") }
    var pluralLearningTitle: String { value("把複數和名詞一起記", "把复数和名词一起记", "Learn the plural with the noun") }
    var pluralLearningDetail: String { value("德語沒有單一複數公式：die Zeitung, die Zeitungen。", "德语没有单一复数公式：die Zeitung, die Zeitungen。", "German has no single plural rule: die Zeitung, die Zeitungen.") }
    var pluralPatternsTitle: String { value("常見形式", "常见形式", "Common patterns") }
    var pluralPatternsDetail: String { value("-e Tage · -er Kinder · -(e)n Frauen · -s Autos · 零詞尾 Lehrer；有時加變音。", "-e Tage · -er Kinder · -(e)n Frauen · -s Autos · 零词尾 Lehrer；有时加变音。", "-e Tage · -er Kinder · -(e)n Frauen · -s Autos · zero ending Lehrer; umlauts may also appear.") }
    var dativePluralTitle: String { value("Dativ 複數多加 -n", "Dativ 复数多加 -n", "Dative plural usually adds -n") }
    var dativePluralDetail: String { value("mit den Kindern；複數已以 -n 或 -s 結尾時不再加。", "mit den Kindern；复数已以 -n 或 -s 结尾时不再加。", "mit den Kindern; do not add another -n after plurals already ending in -n or -s.") }

    var genderTitle: String { value("名詞性別規律", "名词性别规律", "Gender patterns") }
    var feminineTitle: String { value("常見陰性", "常见阴性", "Usually feminine") }
    var neuterTitle: String { value("常見中性", "常见中性", "Usually neuter") }
    var masculineTitle: String { value("常見陽性", "常见阳性", "Often masculine") }
    var masculineDetail: String { value("星期、月份、季節，以及很多 -er 表人名詞。", "星期、月份、季节，以及很多 -er 表人名词。", "Days, months, seasons, and many -er agent nouns.") }
    var verifyTitle: String { value("複合詞看最後一詞", "复合词看最后一词", "Compounds follow the final noun") }
    var verifyDetail: String { value("das Wörterbuch 跟隨 das Buch；不確定時仍要查字典。", "das Wörterbuch 跟随 das Buch；不确定时仍要查词典。", "das Wörterbuch follows das Buch; verify uncertain nouns in a dictionary.") }

    var verbTitle: String { value("動詞位置", "动词位置", "Verb position") }
    var mainClauseTitle: String { value("主句", "主句", "Main clause") }
    var mainClauseDetail: String { value("變位動詞在第 2 位：Heute lerne ich Deutsch.", "变位动词在第 2 位：Heute lerne ich Deutsch.", "The finite verb is second: Heute lerne ich Deutsch.") }
    var questionTitle: String { value("是／否問句", "是／否问句", "Yes/no question") }
    var questionDetail: String { value("變位動詞在第 1 位：Lernst du Deutsch?", "变位动词在第 1 位：Lernst du Deutsch?", "The finite verb is first: Lernst du Deutsch?") }
    var subordinateTitle: String { value("從句", "从句", "Subordinate clause") }
    var subordinateDetail: String { value("weil／dass 從句中，變位動詞到句末。", "weil／dass 从句中，变位动词到句末。", "With weil or dass, the finite verb moves to the end.") }
    var modalTitle: String { value("情態動詞", "情态动词", "Modal verbs") }
    var modalDetail: String { value("情態動詞變位，實義動詞原形放句末。", "情态动词变位，实义动词原形放句末。", "The modal is finite; the main verb stays infinitive at the end.") }

    var conjunctionTitle: String { value("連接詞與語序", "连接词与语序", "Conjunctions & word order") }
    var coordinatingTitle: String { value("und／aber／oder／denn", "und／aber／oder／denn", "und / aber / oder / denn") }
    var coordinatingDetail: String { value("連接兩個主句，不改變動詞第 2 位：Ich lerne, denn ich habe morgen eine Prüfung.", "连接两个主句，不改变动词第 2 位：Ich lerne, denn ich habe morgen eine Prüfung.", "They join main clauses and keep verb-second order: Ich lerne, denn ich habe morgen eine Prüfung.") }
    var subordinatingTitle: String { value("weil／dass／obwohl／wenn", "weil／dass／obwohl／wenn", "weil / dass / obwohl / wenn") }
    var subordinatingDetail: String { value("引導從句，變位動詞放句末：…, weil ich morgen eine Prüfung habe.", "引导从句，变位动词放句末：…, weil ich morgen eine Prüfung habe.", "They introduce a subordinate clause and send the finite verb to the end: …, weil ich morgen eine Prüfung habe.") }
    var connectorAdverbTitle: String { value("deshalb／trotzdem／danach", "deshalb／trotzdem／danach", "deshalb / trotzdem / danach") }
    var connectorAdverbDetail: String { value("它們是副詞，佔主句第 1 位，動詞緊跟：Deshalb lerne ich heute.", "它们是副词，占主句第 1 位，动词紧跟：Deshalb lerne ich heute.", "These are adverbs in position one, followed immediately by the verb: Deshalb lerne ich heute.") }

    var negationTitle: String { value("nicht、kein 與 doch", "nicht、kein 与 doch", "nicht, kein & doch") }
    var keinTitle: String { value("kein 否定名詞", "kein 否定名词", "kein negates a noun") }
    var keinDetail: String { value("用在沒有定冠詞的名詞前，詞尾像 ein：Ich habe kein Auto.", "用在没有定冠词的名词前，词尾像 ein：Ich habe kein Auto.", "Use it before a noun without a definite article; its endings follow ein: Ich habe kein Auto.") }
    var nichtTitle: String { value("nicht 否定其他內容", "nicht 否定其他内容", "nicht negates everything else") }
    var nichtDetail: String { value("可否定動詞、形容詞或特定片語：Ich komme heute nicht.／Das ist nicht teuer.", "可否定动词、形容词或特定短语：Ich komme heute nicht.／Das ist nicht teuer.", "It negates verbs, adjectives, or a particular phrase: Ich komme heute nicht. / Das ist nicht teuer.") }
    var dochTitle: String { value("doch 反駁否定", "doch 反驳否定", "doch contradicts a negative") }
    var dochDetail: String { value("Kommst du nicht? — Doch! 表示「不，我會來」。", "Kommst du nicht? — Doch! 表示“不，我会来”。", "Kommst du nicht? — Doch! means “Actually, yes, I am.”") }

    var wordOrderTitle: String { value("TeKaMoLo：中場排序", "TeKaMoLo：中场排序", "TeKaMoLo: the middle field") }
    var wordOrderRuleTitle: String { value("時間 → 原因 → 方式 → 地點", "时间 → 原因 → 方式 → 地点", "Time → cause → manner → place") }
    var wordOrderRuleDetail: String { value("這是中性預設，不是不能打破的法律。", "这是中性默认，不是不能打破的法律。", "This is a neutral default, not an unbreakable law.") }
    var wordOrderExampleTitle: String { value("完整例句", "完整例句", "Full example") }
    var wordOrderExampleDetail: String { value("Ich fahre morgen wegen des Streiks mit dem Bus nach Berlin.", "Ich fahre morgen wegen des Streiks mit dem Bus nach Berlin.", "Ich fahre morgen wegen des Streiks mit dem Bus nach Berlin.") }

    var perfectTitle: String { value("口語過去式：Perfekt", "口语过去式：Perfekt", "Spoken past: Perfekt") }
    var habenPerfectTitle: String { value("haben + Partizip II", "haben + Partizip II", "haben + past participle") }
    var habenPerfectDetail: String { value("大多數動詞使用 haben：Ich habe Deutsch gelernt.", "大多数动词使用 haben：Ich habe Deutsch gelernt.", "Most verbs use haben: Ich habe Deutsch gelernt.") }
    var seinPerfectTitle: String { value("sein + Partizip II", "sein + Partizip II", "sein + past participle") }
    var seinPerfectDetail: String { value("位置或狀態改變常用 sein：Ich bin nach Hause gegangen.", "位置或状态改变常用 sein：Ich bin nach Hause gegangen.", "Movement or a change of state often uses sein: Ich bin nach Hause gegangen.") }
    var participleTitle: String { value("分詞線索", "分词线索", "Participle clues") }
    var participleDetail: String { value("弱動詞常為 ge-…-t；be-／ver-／er- 等不可分前綴和 -ieren 動詞通常不加 ge-。", "弱动词常为 ge-…-t；be-／ver-／er- 等不可分前缀和 -ieren 动词通常不加 ge-。", "Weak verbs often use ge-…-t; inseparable prefixes such as be-, ver-, and er-, plus -ieren verbs, usually omit ge-.") }

    var separableTitle: String { value("可分動詞", "可分动词", "Separable verbs") }
    var separableMainTitle: String { value("主句：前綴到句末", "主句：前缀到句末", "Main clause: prefix at the end") }
    var separableMainDetail: String { value("Ich stehe um sieben Uhr auf.", "Ich stehe um sieben Uhr auf.", "Ich stehe um sieben Uhr auf.") }
    var separableSubordinateTitle: String { value("從句：重新合在一起", "从句：重新合在一起", "Subordinate clause: reunited") }
    var separableSubordinateDetail: String { value("…, weil ich um sieben Uhr aufstehe.", "…, weil ich um sieben Uhr aufstehe.", "…, weil ich um sieben Uhr aufstehe.") }
    var separablePerfectTitle: String { value("Perfekt：ge- 放進中間", "Perfekt：ge- 放进中间", "Perfekt: ge- goes inside") }
    var separablePerfectDetail: String { value("aufstehen → aufgestanden；einkaufen → eingekauft。", "aufstehen → aufgestanden；einkaufen → eingekauft。", "aufstehen → aufgestanden; einkaufen → eingekauft.") }

    var relativeTitle: String { value("關係子句", "关系从句", "Relative clauses") }
    var relativeAgreementTitle: String { value("性與數看先行詞", "性与数看先行词", "Gender and number follow the antecedent") }
    var relativeAgreementDetail: String { value("der Mann, die Frau, das Kind, die Leute 決定關係代詞的性與數。", "der Mann, die Frau, das Kind, die Leute 决定关系代词的性与数。", "der Mann, die Frau, das Kind, and die Leute determine the pronoun’s gender and number.") }
    var relativeCaseTitle: String { value("格看子句內的工作", "格看从句内的作用", "Case follows the role inside the clause") }
    var relativeCaseDetail: String { value("Das ist der Mann, dem ich geholfen habe. helfen 要 Dativ，所以用 dem。", "Das ist der Mann, dem ich geholfen habe. helfen 要 Dativ，所以用 dem。", "Das ist der Mann, dem ich geholfen habe. helfen takes dative, so the pronoun is dem.") }
    var relativeOrderTitle: String { value("介詞在前，動詞在末", "介词在前，动词在末", "Preposition first, verb last") }
    var relativeOrderDetail: String { value("die Firma, bei der ich arbeite；關係子句的變位動詞放句末。", "die Firma, bei der ich arbeite；关系从句的变位动词放句末。", "die Firma, bei der ich arbeite; the finite verb closes the relative clause.") }

    var passiveTitle: String { value("被動與替代表達", "被动与替代表达", "Passive voice & alternatives") }
    var processPassiveTitle: String { value("過程被動：werden + Partizip II", "过程被动：werden + Partizip II", "Process passive: werden + participle") }
    var processPassiveDetail: String { value("Der Vertrag wird geprüft. 強調動作正在發生。", "Der Vertrag wird geprüft. 强调动作正在发生。", "Der Vertrag wird geprüft. emphasizes the action or process.") }
    var statePassiveTitle: String { value("狀態被動：sein + Partizip II", "状态被动：sein + Partizip II", "State passive: sein + participle") }
    var statePassiveDetail: String { value("Der Vertrag ist unterschrieben. 強調動作完成後的狀態。", "Der Vertrag ist unterschrieben. 强调动作完成后的状态。", "Der Vertrag ist unterschrieben. emphasizes the resulting state.") }
    var passiveAlternativesTitle: String { value("常見替代", "常见替代", "Common alternatives") }
    var passiveAlternativesDetail: String { value("man prüft …／lässt sich prüfen／ist zu prüfen 可避免重複被動，但語氣與強度不同。", "man prüft …／lässt sich prüfen／ist zu prüfen 可避免重复被动，但语气与强度不同。", "man prüft …, lässt sich prüfen, and ist zu prüfen can avoid repeated passives, but differ in tone and force.") }

    var subjunctiveTwoTitle: String { value("Konjunktiv II：假設與禮貌", "Konjunktiv II：假设与礼貌", "Konjunktiv II: hypotheticals & politeness") }
    var counterfactualTitle: String { value("非現實條件", "非现实条件", "Unreal conditions") }
    var counterfactualDetail: String { value("Wenn ich mehr Zeit hätte, würde ich öfter lesen.", "Wenn ich mehr Zeit hätte, würde ich öfter lesen.", "Wenn ich mehr Zeit hätte, würde ich öfter lesen.") }
    var politeSubjunctiveTitle: String { value("降低語氣", "降低语气", "Soften a request") }
    var politeSubjunctiveDetail: String { value("Könnten Sie mir helfen?／Ich hätte gern einen Termin.", "Könnten Sie mir helfen?／Ich hätte gern einen Termin.", "Könnten Sie mir helfen? / Ich hätte gern einen Termin.") }
    var subjunctiveFormTitle: String { value("優先記常用原形", "优先记常用原形", "Prefer the common simple forms") }
    var subjunctiveFormDetail: String { value("wäre、hätte、könnte、müsste 很常用；其他動詞常用 würde + Infinitiv。", "wäre、hätte、könnte、müsste 很常用；其他动词常用 würde + Infinitiv。", "wäre, hätte, könnte, and müsste are common; many other verbs use würde + infinitive.") }

    var reportedSpeechTitle: String { value("Konjunktiv I：間接引語", "Konjunktiv I：间接引语", "Konjunktiv I: reported speech") }
    var reportedSpeechUseTitle: String { value("標示這是他人的說法", "标示这是他人的说法", "Mark another person’s claim") }
    var reportedSpeechUseDetail: String { value("Er sagt, er sei krank und habe keine Zeit. 說話者不直接保證內容為真。", "Er sagt, er sei krank und habe keine Zeit. 说话者不直接保证内容为真。", "Er sagt, er sei krank und habe keine Zeit. The reporter does not personally guarantee the claim.") }
    var reportedSpeechFallbackTitle: String { value("形式相同時改用 Konjunktiv II", "形式相同时改用 Konjunktiv II", "Use Konjunktiv II when forms collide") }
    var reportedSpeechFallbackDetail: String { value("若 Konjunktiv I 與直陳式看不出差別，常用 Konjunktiv II 保持清楚：sie hätten。", "若 Konjunktiv I 与直陈式看不出差别，常用 Konjunktiv II 保持清楚：sie hätten。", "If Konjunktiv I looks identical to the indicative, Konjunktiv II often preserves the distinction: sie hätten.") }

    var infinitiveTitle: String { value("zu 不定式結構", "zu 不定式结构", "Infinitive clauses with zu") }
    var purposeInfinitiveTitle: String { value("um … zu：相同主語的目的", "um … zu：相同主语的目的", "um … zu: purpose with the same subject") }
    var purposeInfinitiveDetail: String { value("Ich lerne jeden Tag, um die Prüfung zu bestehen.", "Ich lerne jeden Tag, um die Prüfung zu bestehen.", "Ich lerne jeden Tag, um die Prüfung zu bestehen.") }
    var alternativeInfinitiveTitle: String { value("ohne／statt … zu", "ohne／statt … zu", "ohne / statt … zu") }
    var alternativeInfinitiveDetail: String { value("Er ging, ohne sich zu verabschieden.／Statt zu lernen, sah er fern.", "Er ging, ohne sich zu verabschieden.／Statt zu lernen, sah er fern.", "Er ging, ohne sich zu verabschieden. / Statt zu lernen, sah er fern.") }
    var infinitivePlacementTitle: String { value("可分動詞把 zu 放中間", "可分动词把 zu 放中间", "zu enters a separable verb") }
    var infinitivePlacementDetail: String { value("anfangen → anzufangen；情態動詞後的原形通常不加 zu。", "anfangen → anzufangen；情态动词后的原形通常不加 zu。", "anfangen → anzufangen; infinitives after modal verbs normally omit zu.") }

    var advancedConnectorsTitle: String { value("B2–C1 連接手段", "B2–C1 连接手段", "B2–C1 connectors") }
    var methodResultTitle: String { value("方法與結果", "方法与结果", "Method and result") }
    var methodResultDetail: String { value("indem 表方法；sodass／so … dass 表結果：Er spart Zeit, indem er online bestellt.", "indem 表方法；sodass／so … dass 表结果：Er spart Zeit, indem er online bestellt.", "indem expresses method; sodass or so … dass expresses a result: Er spart Zeit, indem er online bestellt.") }
    var conditionReasonTitle: String { value("條件與追加理由", "条件与追加理由", "Condition and added reason") }
    var conditionReasonDetail: String { value("sofern 表「只要／假如」；zumal 補充一個特別重要的理由。兩者都把動詞送到句末。", "sofern 表“只要／假如”；zumal 补充一个特别重要的理由。两者都把动词送到句末。", "sofern means “provided that”; zumal adds an especially relevant reason. Both send the verb to the end.") }
    var pairedConnectorTitle: String { value("成對連接", "成对连接", "Paired connectors") }
    var pairedConnectorDetail: String { value("je … desto／einerseits … andererseits／weder … noch／nicht nur … sondern auch。", "je … desto／einerseits … andererseits／weder … noch／nicht nur … sondern auch。", "je … desto, einerseits … andererseits, weder … noch, and nicht nur … sondern auch.") }

    var nominalStyleTitle: String { value("名詞化與分詞修飾", "名词化与分词修饰", "Nominal style & participial attributes") }
    var nominalizationTitle: String { value("名詞化讓正式文本更緊湊", "名词化让正式文本更紧凑", "Nominalization makes formal prose compact") }
    var nominalizationDetail: String { value("weil die Preise steigen → wegen des Preisanstiegs；過度使用會讓句子變重。", "weil die Preise steigen → wegen des Preisanstiegs；过度使用会让句子变重。", "weil die Preise steigen → wegen des Preisanstiegs; overuse can make prose heavy.") }
    var participialAttributeTitle: String { value("分詞可像形容詞一樣修飾", "分词可像形容词一样修饰", "Participles can work like adjectives") }
    var participialAttributeDetail: String { value("die gestern veröffentlichten Zahlen；分詞同樣要配合形容詞詞尾。", "die gestern veröffentlichten Zahlen；分词同样要配合形容词词尾。", "die gestern veröffentlichten Zahlen; the participle takes an adjective ending.") }
    var readabilityTitle: String { value("太長就拆回關係子句", "太长就拆回关系从句", "Unpack long attributes") }
    var readabilityDetail: String { value("修飾鏈太長時，改成 die Zahlen, die gestern veröffentlicht wurden 通常更易讀。", "修饰链太长时，改成 die Zahlen, die gestern veröffentlicht wurden 通常更易读。", "When the modifier becomes too long, die Zahlen, die gestern veröffentlicht wurden is usually easier to read.") }

    var adjectiveTitle: String { value("形容詞詞尾", "形容词词尾", "Adjective endings") }
    var weakTitle: String { value("弱變化：der gute Wein", "弱变化：der gute Wein", "Weak: der gute Wein") }
    var weakDetail: String { value("定冠詞已經標明格和性，形容詞多用 -e 或 -en。", "定冠词已经标明格和性，形容词多用 -e 或 -en。", "The article already marks case and gender, so adjectives mostly take -e or -en.") }
    var mixedTitle: String { value("混合變化：ein guter Wein", "混合变化：ein guter Wein", "Mixed: ein guter Wein") }
    var mixedDetail: String { value("ein 類冠詞缺少部分標記，形容詞要補出 -er／-es。", "ein 类冠词缺少部分标记，形容词要补出 -er／-es。", "Ein-words miss some markers, so the adjective supplies -er or -es.") }
    var strongTitle: String { value("強變化：guter Wein", "强变化：guter Wein", "Strong: guter Wein") }
    var strongDetail: String { value("沒有冠詞時，形容詞承擔主要格／性標記。", "没有冠词时，形容词承担主要格／性标记。", "Without an article, the adjective carries the main case and gender marker.") }

    var prepositionTitle: String { value("介詞支配的格", "介词支配的格", "Preposition cases") }
    var whereTitle: String { "Wo? / Wohin?" }
    var whereDetail: String { value("位置問 Wo? 用 Dativ；方向問 Wohin? 用 Akkusativ。", "位置问 Wo? 用 Dativ；方向问 Wohin? 用 Akkusativ。", "Location asks Wo? and takes dative; direction asks Wohin? and takes accusative.") }

    private func value(_ traditional: String, _ simplified: String, _ english: String) -> String {
        switch language {
        case .traditionalChinese:
            return traditional
        case .simplifiedChinese:
            return simplified
        case .english:
            return english
        }
    }
}

import SwiftUI

struct HomeView: View {
    @AppStorage("grammar_language") private var languageRaw = GrammarLanguage.traditionalChinese.rawValue

    private var text: GrammarCopy {
        GrammarCopy(language: GrammarLanguage(rawValue: languageRaw) ?? .traditionalChinese)
    }

    var body: some View {
        #if os(macOS)
        grammarContent
            .navigationTitle(text.navigationTitle)
        #else
        NavigationStack {
            grammarContent
            .navigationTitle(text.navigationTitle)
        }
        #endif
    }

    private var grammarContent: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 18) {
                GrammarChapterHeader(
                    title: text.foundationsChapterTitle,
                    level: text.foundationsChapterLevel,
                    detail: text.foundationsChapterDetail
                )
                ArticleTableCard(copy: text)
                CaseRolesCard(copy: text)
                PersonalPronounsCard(copy: text)
                NounPluralCard(copy: text)
                GenderPatternCard(copy: text)

                GrammarChapterHeader(
                    title: text.sentencesChapterTitle,
                    level: text.sentencesChapterLevel,
                    detail: text.sentencesChapterDetail
                )
                VerbPositionCard(copy: text)
                ConjunctionCard(copy: text)
                NegationCard(copy: text)
                WordOrderCard(copy: text)

                GrammarChapterHeader(
                    title: text.verbsChapterTitle,
                    level: text.verbsChapterLevel,
                    detail: text.verbsChapterDetail
                )
                PerfectTenseCard(copy: text)
                SeparableVerbsCard(copy: text)

                GrammarChapterHeader(
                    title: text.modifiersChapterTitle,
                    level: text.modifiersChapterLevel,
                    detail: text.modifiersChapterDetail
                )
                AdjectiveEndingsCard(copy: text)
                PrepositionCard(copy: text)

                GrammarChapterHeader(
                    title: text.advancedChapterTitle,
                    level: text.advancedChapterLevel,
                    detail: text.advancedChapterDetail
                )
                RelativeClausesCard(copy: text)
                PassiveVoiceCard(copy: text)
                SubjunctiveTwoCard(copy: text)
                ReportedSpeechCard(copy: text)
                InfinitiveClausesCard(copy: text)
                AdvancedConnectorsCard(copy: text)
                NominalStyleCard(copy: text)
            }
            .frame(maxWidth: 760, alignment: .leading)
            .frame(maxWidth: .infinity)
            .padding(18)
        }
        .background(AppTheme.background)
    }
}

private struct GrammarChapterHeader: View {
    let title: String
    let level: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(AppTheme.primaryText)
                Spacer()
                Text(level)
                    .font(.caption.weight(.bold).monospaced())
                    .foregroundStyle(AppTheme.brand)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 4)
                    .background(AppTheme.brand.opacity(0.12))
                    .clipShape(Capsule())
            }
            Text(detail)
                .font(.footnote)
                .foregroundStyle(AppTheme.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, 8)
    }
}

private struct ArticleTableCard: View {
    let copy: GrammarCopy
    private let rows = [
        ("Nom", "der", "die", "das", "die"),
        ("Akk", "den", "die", "das", "die"),
        ("Dat", "dem", "der", "dem", "den +n"),
        ("Gen", "des +s", "der", "des +s", "der")
    ]

    var body: some View {
        GrammarCard(title: copy.articlesTitle, icon: "text.book.closed", tint: .indigo) {
            VStack(spacing: 0) {
                row(copy.caseLabel, copy.masc, copy.fem, copy.neut, copy.plural, header: true)
                ForEach(rows, id: \.0) { item in
                    Divider()
                    row(item.0, item.1, item.2, item.3, item.4)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(AppTheme.separator))
        }
    }

    private func row(_ a: String, _ b: String, _ c: String, _ d: String, _ e: String, header: Bool = false) -> some View {
        Grid {
            GridRow {
                cell(a, .secondary, header)
                cell(b, .blue, header)
                cell(c, .red, header)
                cell(d, .green, header)
                cell(e, .primary, header)
            }
        }
        .padding(.vertical, 10)
        .background(header ? AppTheme.softSurface : AppTheme.elevatedSurface)
    }

    private func cell(_ text: String, _ color: Color, _ header: Bool) -> some View {
        Text(text)
            .font(header ? .caption.weight(.bold) : .subheadline.weight(.bold))
            .foregroundStyle(color)
            .frame(maxWidth: .infinity)
            .minimumScaleFactor(0.75)
    }
}

private struct CaseRolesCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.caseRolesTitle, icon: "person.2.crop.square.stack", tint: .blue) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.nominativeRoleTitle, detail: copy.nominativeRoleDetail)
                MiniRule(title: copy.accusativeRoleTitle, detail: copy.accusativeRoleDetail)
                MiniRule(title: copy.dativeRoleTitle, detail: copy.dativeRoleDetail)
                MiniRule(title: copy.genitiveRoleTitle, detail: copy.genitiveRoleDetail)
            }
        }
    }
}

private struct PersonalPronounsCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.pronounsTitle, icon: "person.3", tint: .purple) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: "Nominativ", detail: copy.nominativePronouns)
                MiniRule(title: "Akkusativ", detail: copy.accusativePronouns)
                MiniRule(title: "Dativ", detail: copy.dativePronouns)
                MiniRule(title: copy.pronounNoteTitle, detail: copy.pronounNoteDetail)
            }
        }
    }
}

private struct NounPluralCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.pluralTitle, icon: "square.on.square", tint: .mint) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.pluralLearningTitle, detail: copy.pluralLearningDetail)
                MiniRule(title: copy.pluralPatternsTitle, detail: copy.pluralPatternsDetail)
                MiniRule(title: copy.dativePluralTitle, detail: copy.dativePluralDetail)
            }
        }
    }
}

private struct AdjectiveEndingsCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.adjectiveTitle, icon: "paintbrush.pointed", tint: .orange) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.weakTitle, detail: copy.weakDetail)
                MiniRule(title: copy.mixedTitle, detail: copy.mixedDetail)
                MiniRule(title: copy.strongTitle, detail: copy.strongDetail)
            }
        }
    }
}

private struct PrepositionCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.prepositionTitle, icon: "arrow.triangle.branch", tint: .teal) {
            VStack(alignment: .leading, spacing: 18) {
                ChipGroup(title: "Akkusativ", tint: .red, words: ["durch", "für", "gegen", "ohne", "um", "bis"])
                ChipGroup(title: "Dativ", tint: .blue, words: ["aus", "bei", "mit", "nach", "seit", "von", "zu", "gegenüber"])
                ChipGroup(title: "Wechsel", tint: .purple, words: ["an", "auf", "hinter", "in", "neben", "über", "unter", "vor", "zwischen"])
                MiniRule(title: copy.whereTitle, detail: copy.whereDetail)
            }
        }
    }
}

private struct VerbPositionCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.verbTitle, icon: "arrow.left.arrow.right", tint: .cyan) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.mainClauseTitle, detail: copy.mainClauseDetail)
                MiniRule(title: copy.questionTitle, detail: copy.questionDetail)
                MiniRule(title: copy.subordinateTitle, detail: copy.subordinateDetail)
                MiniRule(title: copy.modalTitle, detail: copy.modalDetail)
            }
        }
    }
}

private struct ConjunctionCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.conjunctionTitle, icon: "link", tint: .indigo) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.coordinatingTitle, detail: copy.coordinatingDetail)
                MiniRule(title: copy.subordinatingTitle, detail: copy.subordinatingDetail)
                MiniRule(title: copy.connectorAdverbTitle, detail: copy.connectorAdverbDetail)
            }
        }
    }
}

private struct NegationCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.negationTitle, icon: "nosign", tint: .red) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.keinTitle, detail: copy.keinDetail)
                MiniRule(title: copy.nichtTitle, detail: copy.nichtDetail)
                MiniRule(title: copy.dochTitle, detail: copy.dochDetail)
            }
        }
    }
}

private struct WordOrderCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.wordOrderTitle, icon: "list.number", tint: .brown) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.wordOrderRuleTitle, detail: copy.wordOrderRuleDetail)
                MiniRule(title: copy.wordOrderExampleTitle, detail: copy.wordOrderExampleDetail)
            }
        }
    }
}

private struct PerfectTenseCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.perfectTitle, icon: "clock.arrow.circlepath", tint: .orange) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.habenPerfectTitle, detail: copy.habenPerfectDetail)
                MiniRule(title: copy.seinPerfectTitle, detail: copy.seinPerfectDetail)
                MiniRule(title: copy.participleTitle, detail: copy.participleDetail)
            }
        }
    }
}

private struct SeparableVerbsCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.separableTitle, icon: "arrow.left.and.right", tint: .pink) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.separableMainTitle, detail: copy.separableMainDetail)
                MiniRule(title: copy.separableSubordinateTitle, detail: copy.separableSubordinateDetail)
                MiniRule(title: copy.separablePerfectTitle, detail: copy.separablePerfectDetail)
            }
        }
    }
}

private struct GenderPatternCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.genderTitle, icon: "circle.hexagongrid", tint: .green) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.feminineTitle, detail: "-ung, -heit, -keit, -schaft, -ei, -ion, -tät")
                MiniRule(title: copy.neuterTitle, detail: "-chen, -lein, substantivierte Infinitive")
                MiniRule(title: copy.masculineTitle, detail: copy.masculineDetail)
                MiniRule(title: copy.verifyTitle, detail: copy.verifyDetail)
            }
        }
    }
}

private struct RelativeClausesCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.relativeTitle, icon: "text.append", tint: .blue) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.relativeAgreementTitle, detail: copy.relativeAgreementDetail)
                MiniRule(title: copy.relativeCaseTitle, detail: copy.relativeCaseDetail)
                MiniRule(title: copy.relativeOrderTitle, detail: copy.relativeOrderDetail)
            }
        }
    }
}

private struct PassiveVoiceCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.passiveTitle, icon: "arrow.trianglehead.2.clockwise.rotate.90", tint: .teal) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.processPassiveTitle, detail: copy.processPassiveDetail)
                MiniRule(title: copy.statePassiveTitle, detail: copy.statePassiveDetail)
                MiniRule(title: copy.passiveAlternativesTitle, detail: copy.passiveAlternativesDetail)
            }
        }
    }
}

private struct SubjunctiveTwoCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.subjunctiveTwoTitle, icon: "cloud", tint: .purple) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.counterfactualTitle, detail: copy.counterfactualDetail)
                MiniRule(title: copy.politeSubjunctiveTitle, detail: copy.politeSubjunctiveDetail)
                MiniRule(title: copy.subjunctiveFormTitle, detail: copy.subjunctiveFormDetail)
            }
        }
    }
}

private struct ReportedSpeechCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.reportedSpeechTitle, icon: "quote.bubble", tint: .cyan) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.reportedSpeechUseTitle, detail: copy.reportedSpeechUseDetail)
                MiniRule(title: copy.reportedSpeechFallbackTitle, detail: copy.reportedSpeechFallbackDetail)
            }
        }
    }
}

private struct InfinitiveClausesCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.infinitiveTitle, icon: "arrow.right.to.line", tint: .orange) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.purposeInfinitiveTitle, detail: copy.purposeInfinitiveDetail)
                MiniRule(title: copy.alternativeInfinitiveTitle, detail: copy.alternativeInfinitiveDetail)
                MiniRule(title: copy.infinitivePlacementTitle, detail: copy.infinitivePlacementDetail)
            }
        }
    }
}

private struct AdvancedConnectorsCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.advancedConnectorsTitle, icon: "point.3.connected.trianglepath.dotted", tint: .indigo) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.methodResultTitle, detail: copy.methodResultDetail)
                MiniRule(title: copy.conditionReasonTitle, detail: copy.conditionReasonDetail)
                MiniRule(title: copy.pairedConnectorTitle, detail: copy.pairedConnectorDetail)
            }
        }
    }
}

private struct NominalStyleCard: View {
    let copy: GrammarCopy

    var body: some View {
        GrammarCard(title: copy.nominalStyleTitle, icon: "doc.text", tint: .green) {
            VStack(alignment: .leading, spacing: 12) {
                MiniRule(title: copy.nominalizationTitle, detail: copy.nominalizationDetail)
                MiniRule(title: copy.participialAttributeTitle, detail: copy.participialAttributeDetail)
                MiniRule(title: copy.readabilityTitle, detail: copy.readabilityDetail)
            }
        }
    }
}

private struct GrammarCard<Content: View>: View {
    let title: String
    let icon: String
    let tint: Color
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label(title, systemImage: icon)
                .font(.headline.weight(.bold))
                .foregroundStyle(tint)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(AppTheme.elevatedSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(AppTheme.separator))
    }
}

private struct MiniRule: View {
    let title: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(AppTheme.primaryText)
            Text(detail)
                .font(.footnote)
                .foregroundStyle(AppTheme.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

private struct ChipGroup: View {
    let title: String
    let tint: Color
    let words: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption.weight(.bold))
                .foregroundStyle(tint)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 92), spacing: 10)], alignment: .leading, spacing: 10) {
                ForEach(words, id: \.self) { word in
                    Text(word)
                        .font(.subheadline.weight(.semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.82)
                        .frame(maxWidth: .infinity, minHeight: 36)
                        .padding(.horizontal, 10)
                        .background(tint.opacity(0.14))
                        .foregroundStyle(tint)
                        .clipShape(Capsule())
                }
            }
        }
    }
}

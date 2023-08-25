//
//  AppColors.swift
//  AppKit
//
//  Created by Chaitanya Soni on 25/08/22.
//

//import Foundation
/*
 This file will be the consolidation of all the colors used, here no colors will be mentioned but just the properties for which values will be injected according to the targets
 This makes sharing codebase with different themed apps easy
 
 */


/*
 Eg.
 
 public struct AppColors {
 
 public init(brandColor: ColorCombination, backgroundGradiantColors: [UIColor], gradiantColors: [UIColor], textColor: ColorCombination, dividerColor: UIColor, disabledColor: UIColor, illustrationColors: IllustrationColors, dataVisualisationColors: DataVisualisationColors) {
 
 self.brandColor = brandColor
 self.backgroundGradiantColors = backgroundGradiantColors
 self.gradiantColors = gradiantColors
 self.textColor = textColor
 self.dividerColor = dividerColor
 self.disabledColor = disabledColor
 self.illustrationColors = illustrationColors
 self.dataVisualisationColors = dataVisualisationColors
 
 
 
 }
 
 public let brandColor: ColorCombination
 public let backgroundGradiantColors: [UIColor]
 public let gradiantColors: [UIColor]
 public let textColor: ColorCombination
 
 public let dividerColor: UIColor
 public let disabledColor: UIColor
 
 public let illustrationColors: IllustrationColors
 
 public let dataVisualisationColors: DataVisualisationColors
 }
 
 public struct ColorCombination {
 public init(primaryColor: UIColor, secondaryColor: UIColor) {
 self.primaryColor = primaryColor
 self.secondaryColor = secondaryColor
 }
 public let primaryColor: UIColor
 public let secondaryColor: UIColor
 }
 
 public struct IllustrationColors {
 public init(one: ColorCombination, two: ColorCombination, three: ColorCombination, four: ColorCombination, five: ColorCombination, six: ColorCombination, seven: ColorCombination) {
 self.one = one
 self.two = two
 self.three = three
 self.four = four
 self.five = five
 self.six = six
 self.seven = seven
 }
 public let one: ColorCombination
 public let two: ColorCombination
 public let three: ColorCombination
 public let four: ColorCombination
 public let five: ColorCombination
 public let six: ColorCombination
 public let seven: ColorCombination
 }
 
 public struct DataVisualisationColors {
 
 public init(one: UIColor, two: UIColor, three: UIColor, four: UIColor, five: UIColor, six: UIColor, seven: UIColor, eight: UIColor, nine: UIColor, ten: UIColor, eleven: UIColor, twelve: UIColor, thirteen: UIColor, fourteen: UIColor, fifteen: UIColor, sixteen: UIColor, seventeen: UIColor, eighteen: UIColor) {
 self.one = one
 self.two = two
 self.three = three
 self.four = four
 self.five = five
 self.six = six
 self.seven = seven
 self.eight = eight
 self.nine = nine
 self.ten = ten
 self.eleven = eleven
 self.twelve = twelve
 self.thirteen = thirteen
 self.fourteen = fourteen
 self.fifteen = fifteen
 self.sixteen = sixteen
 self.seventeen = seventeen
 self.eighteen = eighteen
 }
 
 
 public let one: UIColor
 public let two: UIColor
 public let three: UIColor
 public let four: UIColor
 public let five: UIColor
 public let six: UIColor
 public let seven: UIColor
 public let eight: UIColor
 public let nine: UIColor
 public let ten: UIColor
 public let eleven: UIColor
 public let twelve: UIColor
 public let thirteen: UIColor
 public let fourteen: UIColor
 public let fifteen: UIColor
 public let sixteen: UIColor
 public let seventeen: UIColor
 public let eighteen: UIColor
 }

 
 
 
 */


/*
 
 extension AppColors {
 static let greenTheme: AppColors = {
 
 let illustrationColors = IllustrationColors(one: ColorCombination.init(primaryColor: UIColor(red: 0.22, green: 0.71, blue: 0.29, alpha: 1.00) /*UIColor.hex("#39B54A")*/, secondaryColor: UIColor(red: 0.55, green: 0.78, blue: 0.24, alpha: 1.00) /*UIColor.hex("#8CC63E")*/),
 two: ColorCombination.init(primaryColor: UIColor(red: 0.95, green: 0.60, blue: 0.14, alpha: 1.00) /*UIColor.hex("#F29823")*/, secondaryColor: UIColor.hex("#FFCA12")),
 three: ColorCombination.init(primaryColor: UIColor.hex("#FC4C1A"), secondaryColor: UIColor.hex("#F39624")),
 four: ColorCombination.init(primaryColor: UIColor.hex("#FC1A1A"), secondaryColor: UIColor.hex("#F55A33")),
 five: ColorCombination.init(primaryColor: UIColor.hex("#FF5156"), secondaryColor: UIColor.hex("#FE756B")),
 six: ColorCombination.init(primaryColor: UIColor.hex("#02DEB5"), secondaryColor: UIColor.hex("#21C2BC")),
 seven: ColorCombination.init(primaryColor: UIColor.hex("#0488E8"), secondaryColor: UIColor.hex("#1AA4ED")))
 
 let dataVisualisationColors = DataVisualisationColors(one: UIColor.hex("#EA6663"),
 two: UIColor.hex("#E04F84"),
 three: UIColor.hex("#A856BD"),
 four: UIColor.hex("#8263C2"),
 five: UIColor.hex("#6672BE"),
 six: UIColor.hex("#51A3EA"),
 seven: UIColor.hex("#3CB1EA"),
 eight: UIColor.hex("#3ABFCF"),
 nine: UIColor.hex("#3AA398"),
 ten: UIColor.hex("#6EB570"),
 eleven: UIColor.hex("#99C46D"),
 twelve: UIColor.hex("#CED661"),
 thirteen: UIColor.hex("#FDE063"),
 fourteen: UIColor.hex("#FFC43A"),
 fifteen: UIColor.hex("#FBA63A"),
 sixteen: UIColor.hex("#F67851"),
 seventeen: UIColor.hex("#8E756C"),
 eighteen: UIColor.hex("#7B8F97"))
 
 return AppColors(brandColor: ColorCombination.init(primaryColor: UIColor(red: 0.22, green: 0.71, blue: 0.29, alpha: 1.00) /*UIColor.hex("#39B54A")*/, secondaryColor: UIColor(red: 0.55, green: 0.78, blue: 0.24, alpha: 1.00) /*UIColor.hex("#8CC63E")*/), backgroundGradiantColors: [UIColor.hex("#A2D7FF"), UIColor.hex("#1C4DAC")],
 gradiantColors: [UIColor(red: 0.22, green: 0.71, blue: 0.29, alpha: 1.00) /*UIColor.hex("#39B54A")*/, UIColor(red: 0.55, green: 0.78, blue: 0.24, alpha: 1.00) /*UIColor.hex("#8CC63E")*/],
 textColor: ColorCombination.init(primaryColor: UIColor.hex("#252525"), secondaryColor: UIColor.hex("#848484")),
 dividerColor: UIColor.hex("#EEEEEE"),
 disabledColor: UIColor.hex("#CFCFCF"),
 illustrationColors: illustrationColors,
 dataVisualisationColors: dataVisualisationColors)
 
 }()
 
 }
 
 */


/*
 
 
 extension AppColors {
 
 static let blueTheme: AppColors = {
 
 let illustrationColors = IllustrationColors(one: ColorCombination.init(primaryColor: UIColor.hex("#A6E3FF"), secondaryColor: UIColor.hex("#0070C4")),
 two: ColorCombination.init(primaryColor: UIColor.hex("#FFE6E6"), secondaryColor: UIColor.hex("#F03C3B")),
 three: ColorCombination.init(primaryColor: .clear, secondaryColor: .clear),
 four: ColorCombination.init(primaryColor: .clear, secondaryColor: .clear),
 five: ColorCombination.init(primaryColor: .clear, secondaryColor: .clear),
 six: ColorCombination.init(primaryColor: .clear, secondaryColor: .clear),
 seven: ColorCombination.init(primaryColor: .clear, secondaryColor: .clear))
 
 let dataVisualisationColors = DataVisualisationColors(one: UIColor.hex("#EA6663"),
 two: UIColor.hex("#3295C2"),
 three: UIColor.hex("#09E0F6"),
 four: UIColor.hex("#8263C2"),
 five: UIColor.hex("#6672BE"),
 six: UIColor.hex("#51A3EA"),
 seven: UIColor.hex("#3CB1EA"),
 eight: UIColor.hex("#3ABFCF"),
 nine: UIColor.hex("#3AA398"),
 ten: UIColor.hex("#6EB570"),
 eleven: UIColor.hex("#99C46D"),
 twelve: UIColor.hex("#CED661"),
 thirteen: .clear,
 fourteen: .clear,
 fifteen: .clear,
 sixteen: .clear,
 seventeen: .clear,
 eighteen: .clear)
 
 return AppColors(brandColor: ColorCombination.init(primaryColor: UIColor.hex("#0f4585"), secondaryColor: UIColor.hex("#d72716")), backgroundGradiantColors: [UIColor.hex("#A2D7FF"), UIColor.hex("#A2D7FF"), UIColor.hex("#1C4DAC"), UIColor.hex("#1C4DAC"), UIColor.hex("#1C4DAC")],
 gradiantColors: [UIColor.hex("#022D85"), UIColor.hex("#5984B5")],
 textColor: ColorCombination.init(primaryColor: UIColor.hex("#263238"), secondaryColor: UIColor.hex("#78909c")),
 dividerColor: UIColor.hex("#f5f5f5"),
 disabledColor: UIColor.hex("#e4e9eb"),
 illustrationColors: illustrationColors,
 dataVisualisationColors: dataVisualisationColors)
 
 }()
 }
 
 */


/*
 
 
 class AppSettings {
 static let shared: AppSettings = AppSettings()
 
 let appColors: AppColors
 let appFonts: AppFont = AppFont()
 
 
 init() {
 #if GreenTarget
 self.appColors = AppColors.blueTheme
 #elseif BlueTarget
 self.appColors = AppColors.greenTheme
 #endif
 
 }
 
 
 }
 
 */

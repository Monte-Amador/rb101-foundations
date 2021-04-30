# Launch School - An Online School For Software Engineers

> Starting with this lesson, we're going to change our coding style a bit. That is, we won't preface methods with Kernel. or append the optional parentheses during method invocation. Starting with this lesson, use the following Rubocop configuration file. Copy and paste the below into a .rubocop.yml file in your lesson_6 directory. Don't forget to make sure you are using Rubocop version 0.86.0 if you can. For a refresher on how to check or change your current Rubocop version, revisit this previous Rubocop assignment.

Starting with this lesson, we're going to change our coding style a bit. That is, we won't preface methods with `Kernel.` or append the optional parentheses during method invocation. Starting with this lesson, use the following Rubocop configuration file. Copy and paste the below into a `.rubocop.yml` file in your `lesson_6` directory. Don't forget to make sure you are using Rubocop version 0.86.0 if you can. For a refresher on how to check or change your current Rubocop version, revisit this previous Rubocop [assignment](https://launchschool.com/lessons/a0f3cd44/assignments/8e770c8a).

    
    
    AllCops:
      
      DisplayCopNames: true
      
      ExtraDetails: true
      
      
      
      DisplayStyleGuide: true
      
      
      StyleGuideBaseURL: https://github.com/bbatsov/ruby-style-guide
      
      
      TargetRubyVersion: 2.4
    
    Style/BlockComments:
      Description: 'Do not use block comments.'
      Enabled: false
    
    Style/CommandLiteral:
      Description: 'Use `` or %x around command literals.'
      Enabled: true
      
      
      
      EnforcedStyle: mixed
      SupportedStyles:
        - backticks
        - percent_x
        - mixed
      
      
      AllowInnerBackticks: false
    
    Style/CommentAnnotation:
      Description: >-
        Checks formatting of special comments (TODO, FIXME, OPTIMIZE, HACK, REVIEW).
      Enabled: false
    
    Style/Documentation:
      Description: 'Document classes and non-namespace modules.'
      Enabled: false
    
    Style/DoubleNegation:
      Description: 'Checks for uses of double negation (!!).'
      Enabled: false
    
    Layout/EmptyLineBetweenDefs:
      Enabled: true
      AllowAdjacentOneLineDefs: true
    
    Style/EmptyLiteral:
      Description: Prefer literals to Array.new/Hash.new/String.new.
      Enabled: false
    
    Style/FrozenStringLiteralComment:
      Enabled: false
      Description: Require the addition of the frozen string literal comment.
    
    Style/GuardClause:
      Description: Check for conditionals that can be replaced with guard clauses.
      Enabled: false
    
    Style/HashSyntax:
      Description: >-
                     Prefer Ruby 1.9 hash syntax { a: 1, b: 2 } over 1.8 syntax
                     { :a => 1, :b => 2 }.
      Enabled: true
      EnforcedStyle: ruby19_no_mixed_keys
      UseHashRocketsWithSymbolValues: false
      PreferHashRocketsForNonAlnumEndingSymbols: false
    
    Style/IfUnlessModifier:
      Description: >-
                     Favor modifier if/unless usage when you have a
                     single-line body.
      Enabled: false
    
    Style/InlineComment:
      Description: Avoid inline comments.
      Enabled: false
    
    Style/MethodCallWithoutArgsParentheses:
      Description: Do not use parentheses for method calls with no arguments.
      Enabled: true
    
    Style/ModuleFunction:
      Description: Checks for usage of `extend self` in modules.
      Enabled: false
    
    Style/MutableConstant:
      Description: Freeze mutable constants.
      Enabled: false
    
    Style/NegatedIf:
      Description: >-
                     Favor unless over if for negative conditions
                     (or control flow or).
      Enabled: false
    
    Style/NegatedWhile:
      Description: 'Favor until over while for negative conditions.'
      Enabled: false
    
    Style/Next:
      Description: 'Use `next` to skip iteration instead of a condition at the end.'
      Enabled: false
    
    Style/NumericLiterals:
      Description: Add underscores to large numeric literals to improve their readability.
      Enabled: false
    
    Style/NumericPredicate:
      Description: >-
                     Checks for the use of predicate- or comparison methods for
                     numeric comparisons.
      Enabled: false
    
    Style/OneLineConditional:
      Description: Favor the ternary operator(?:) over if/then/else/end constructs.
      Enabled: false
    
    Naming/BinaryOperatorParameterName:
      Description: When defining binary operators, name the argument other.
      Enabled: false
    
    Style/ParenthesesAroundCondition:
      Description: >-
                     Don't use parentheses around the condition of an
                     if/unless/while.
      Enabled: true
      AllowSafeAssignment: false
    
    Style/PercentLiteralDelimiters:
      Description: 'Use `%`-literal delimiters consistently'
      Enabled: true
      PreferredDelimiters:
        '%':  ()
        '%i': ()
        '%I': ()
        '%q': ()
        '%Q': ()
        '%r': ()
        '%s': ()
        '%w': ()
        '%W': ()
        '%x': ()
    
    Style/PerlBackrefs:
      Description: Avoid Perl-style regex back references.
      Enabled: false
    
    Style/Proc:
      Description: Use proc instead of Proc.new.
      Enabled: false
    
    Style/RedundantFetchBlock:
      Description: Only way to keep FetchBlock warning from popping up.
      Enabled: true
    
    Style/RedundantParentheses:
      Enabled: false
    
    Style/RedundantReturn:
      Description: "Don't use return where it's not required."
      Enabled: true
      
      AllowMultipleReturnValues: true
    
    Style/RegexpLiteral:
      Description: 'Use / or %r around regular expressions.'
      Enabled: true
      EnforcedStyle: mixed
      AllowInnerSlashes: false
    
    Style/SafeNavigation:
      Description: >-
                      This cop transforms usages of a method call safeguarded by
                      a check for the existance of the object to
                      safe navigation (`&.`).
      Enabled: false
    
    Style/SingleLineBlockParams:
      Description: Enforces the names of some block params.
      Enabled: false
    
    Style/SingleLineMethods:
      Description: Avoid single-line methods.
      Enabled: false
    
    Layout/SpaceAroundEqualsInParameterDefault:
      Enabled: false
    
    Style/StringLiterals:
      Description: Force use of single or double quotes when no interpolation
      Enabled: false
    
    Style/SymbolArray:
      Description: 'Use %i or %I for arrays of symbols.'
      StyleGuide: '
      Enabled: false
    
    Style/WhileUntilModifier:
      Description: Favor modifier while/until usage when you have a single-line body.
      Enabled: false
    
    Style/WordArray:
      Description: 'Use %w or %W for arrays of words.'
      Enabled: false
    
    Metrics/AbcSize:
      Description: >-
                     A calculated magnitude based on number of assignments,
                     branches, and conditions.
      Enabled: true
      Max: 18
    
    Metrics/BlockLength:
      Description: Limit size of blocks.
      Enabled: false
    
    Metrics/ClassLength:
      Description: 'Avoid classes longer than 100 lines of code.'
      Enabled: false
    
    Layout/LineLength:
      Description: Limit lines to 80 characters.
      Enabled: true
      Max: 80
      StyleGuide: https://github.com/bbatsov/ruby-style-guide
      AllowURI: true
      URISchemes:
      - http
      - https
    
    Metrics/MethodLength:
      Description: 'Avoid methods longer than 15 lines of code.'
      Enabled: true
      CountComments: false  
      Max: 15
    
    Lint/LiteralInInterpolation:
      Description: 'Avoid interpolating literals in strings'
      AutoCorrect: false
      Enabled: true
    
    Layout/EmptyLinesAroundAttributeAccessor:
      Description: 'Checks for a newline after an attribute accessor or a group of them.'
      Enabled: true
    
    Layout/SpaceAroundMethodCallOperator:
      Description: 'Checks method call operators to not have spaces around them.'
      Enabled: true
    
    Lint/DeprecatedOpenSSLConstant:
      Description: 'Algorithmic constants for OpenSSL::Cipher and OpenSSL::Digest deprecated since OpenSSL version 2.2.0. Prefer passing a string instead.'
      Enabled: false
    
    Lint/MixedRegexpCaptureTypes:
      Description: 'Do not mix named captures and numbered captures'
      Enabled: false
    
    Lint/RaiseException:
      Description: 'Checks for raise or fail statements which are raising Exception class.'
      Enabled: false
    
    Lint/StructNewOverride:
      Description: 'Checks unexpected overrides of the Struct built-in methods via Struct.new'
      Enabled: false
    
    Style/ExponentialNotation:
      Description: 'Enforces consistency when using exponential notation for numbers in the code'
      Enabled: false
    
    Style/HashTransformKeys:
      Description: 'Tries to use a simpler & faster call to transform_keys where possible'
      Enabled: false
    
    Style/HashTransformValues:
      Description: 'Tries to use a simpler & faster call to transform_values where possible'
      Enabled: false
    
    Style/RedundantRegexpCharacterClass:
      Description: 'Checks for unnecessary single-element Regexp character classes.'
      Enabled: false
    
    Style/RedundantRegexpEscape:
      Description: 'Checks for redundant escapes inside Regexp literals'
      Enabled: false
    
    Style/SlicingWithRange:
      Description: 'Checks that arrays are sliced with endless ranges instead of ary[start..-1]'
      Enabled: false
    
    Layout/EmptyLineAfterGuardClause:
      Description: 'Requires empty line after guard clause'
      Enabled: false
    
    Style/FloatDivision:
      Description: 'Checks for division with integers coerced to floats.'
      Enabled: false
    
    Naming/MethodParameterName:
      Description: 'Parameter names at least 3 characters long'
      Enabled: false
    
    Style/ConditionalAssignment:
      Description: 'Use return value of conditional for assignment'
      Enabled: true
    
    Naming/AccessorMethodName:
      Description: 'Do not prefix reader method names with get_'
      Enabled: true
    
    Style/NegatedUnless:
      Description: 'Favor if over unless'
      Enabled: false
    
    Style/MultipleComparison:
      Description: 'Avoid comparing variable with multiple items'
      Enabled: false
    
    Layout/HeredocIndentation:
      Description: 'Checks the indentation of the here document bodies'
      Enabled: false
    
    Layout/ClosingHeredocIndentation:
      Description: 'Checks the indentation of here document closings.'
      Enabled: false
    
    Style/CommentedKeyword:
      Description: 'Comments should not be on same line as def'
      Enabled: false
    
    Style/FormatStringToken:
      Description: 'Prefer annotated tokens over unannotated'
      Enabled: false
    
    Style/HashEachMethods:
      Description: 'each_key over keys.each'
      Enabled: false
    
    Style/MultilineWhenThen:
      Description: 'Avoid then for multiline when statement'
      Enabled: false
    
    Style/InverseMethods:
      Description: 'reject instead of reversed select'
      Enabled: false
    
    Style/ZeroLengthPredicate:
      Description: 'empty? instead of length == 0'
      Enabled: false
    

You marked this topic or exercise as completed.


[Source](https://launchschool.com/lessons/de05b300/assignments/99294729)
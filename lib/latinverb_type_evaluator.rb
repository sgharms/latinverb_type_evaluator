#encoding: UTF-8
require "forwardable"
require "latinverb_deponent_string_deriver"
require "linguistics_latin"
require "latinverb_type_evaluator/version"

module Linguistics
  module Latin
    module Verb
      class LatinVerb
        class TypeEvaluator
          FIRST_PRESENT_ACTIVE_INFINITIVE_ENDING = /āre$/
          SECOND_PRESENT_ACTIVE_INFINITIVE_ENDING = /ēre$/
          THIRD_PRESENT_ACTIVE_INFINITIVE_ENDING = /ere$/
          FOURTH_PRESENT_ACTIVE_INFINITIVE_ENDING = /.+īre$/
          THIRDIO_DETERMINANT_FIRST_PERSON_SINGULAR_PATTERN = /i.$/
          DEPONENT_VERB_PRESENT_ACTIVE_INFINITIVE_ENDING = /ī$/
          DEPONENT_VERB_FIRST_PERSON_SINGULAR_ENDING = /r$/

          extend Forwardable

          # "Type" is key stem associated with the verb versus the
          # classification.  i.e. a verb might be "classified" as "Deponent"
          # but has a "type" of first conjugation e.g. miror / mirari
          def_delegators :@verb, :first_person_singular, :present_active_infinitive

          def initialize(verb)
            @verb = verb
          end

          def type
            if present_active_infinitive =~ FIRST_PRESENT_ACTIVE_INFINITIVE_ENDING
              Linguistics::Latin::Verb::VerbTypes::First
            elsif present_active_infinitive =~ SECOND_PRESENT_ACTIVE_INFINITIVE_ENDING
              Linguistics::Latin::Verb::VerbTypes::Second
            elsif present_active_infinitive =~ THIRD_PRESENT_ACTIVE_INFINITIVE_ENDING
              first_person_singular =~ THIRDIO_DETERMINANT_FIRST_PERSON_SINGULAR_PATTERN ? Linguistics::Latin::Verb::VerbTypes::ThirdIO : Linguistics::Latin::Verb::VerbTypes::Third
            elsif present_active_infinitive =~ FOURTH_PRESENT_ACTIVE_INFINITIVE_ENDING
              Linguistics::Latin::Verb::VerbTypes::Fourth
            elsif (present_active_infinitive =~ DEPONENT_VERB_PRESENT_ACTIVE_INFINITIVE_ENDING and first_person_singular =~ DEPONENT_VERB_FIRST_PERSON_SINGULAR_ENDING)
              str = DeponentStringDeriver.new(@verb.original_string).proxy_string.split(/\s+/)
              Linguistics::Latin::Verb::LatinVerb::TypeEvaluator.new(OpenStruct.new(
                first_person_singular: str.shift,
                present_active_infinitive: str.shift
              )).type
            # Sometimes something is not classified as irregular but has
            # aberrations e.g. pluit.  Try to pull it from storage.
            else
              Linguistics::Latin::Verb::VerbTypes::Irregular
            end
          end

          def short_type
            type.to_s.split('::').last.to_sym
          end
        end
      end
    end
  end
end

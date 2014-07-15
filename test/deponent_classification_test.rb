class DeponentClassificationTest < Minitest::Test
  def setup
    @a_deponent_string = 'mīror mīrārī mīrātum'
  end

  def test_deponent
    str = Linguistics::Latin::Verb::LatinVerb::DeponentStringDeriver.new(@a_deponent_string).proxy_string.split(/\s+/)
    assert_equal Linguistics::Latin::Verb::LatinVerb::TypeEvaluator.new(OpenStruct.new(
      first_person_singular: str.shift,
      present_active_infinitive: str.shift)).type, Linguistics::Latin::Verb::VerbTypes::First
  end
end

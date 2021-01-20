def test_person_3_is_james(testapp):
    res = testapp.get(
        "/api/person", params={"id": 3}
    )
    assert res.json["name"] == "James"


def test_person_5_not_found(testapp):
    res = testapp.get(
        "/api/person", params={"id": 5}
    )
    assert res.json == {}

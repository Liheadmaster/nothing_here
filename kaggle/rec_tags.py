#-*- coding: utf-8 -*-
import pymongo
import re
import cPickle
from collections import defaultdict

yh_re = re.compile('""')
tag_re = re.compile("<[^>]*>")

word_re = re.compile("([a-zA-Z.-]+)")

buffer_size = 30*1024*1024


def get_conn():
    _conn = pymongo.Connection("localhost")
    _mydb = _conn["Desktop"]
    return _conn, _mydb

def load_data(name):
    tmp_file = open(name  + ".pkl", "r")
    rts = cPickle.loads(tmp_file.read())
    tmp_file.close()

    return rts

def save_data(data, name):
    tmp_file = open(name  + ".pkl", "w")
    tmp_file.write(cPickle.dumps(data))
    tmp_file.close()

def test_tag_map(db):
    tag_map = defaultdict(int)
    _cur = db.train_data.find()
    for item in _cur:
        tags = item["tags"].split(" ")
        for tag in tags:
            tag_map[tag] += 1
    return tag_map

def add_segword(db):
    cur = db.train_data.find({"segword": None})
    cnt = 0
    for item in cur:
        if "segword" in item:
            continue
        item["content"] = tag_re.sub("", item["content"])
        content = word_re.findall(item["content"])
        db.train_data.update(
            {"_id": item["_id"]},
            {
                "$set": {
                    "segword": content
                }
            }
        )
        cnt += 1
        if cnt%10000 == 0:
            print cnt
    
if __name__ == "__main__":
    conn, mydb = get_conn()
    add_segword(mydb)


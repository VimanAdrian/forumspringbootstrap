INSERT INTO virtual_classes (virtual_class_id,
                             owner,
                             title,
                             description,
                             created,
                             last_active,
                             visibility,
                             score,
                             views,
                             active,
                             deleted)

VALUES (0,
  0,
  'Getting started with MemoryLeak',
  'Greetings, and welcome to MemoryLeak.


MemoryLeak is a website run by developers for developers. Here you can ask questions, read tutorials or even get involved and create your own classes where people can learn from you.


In the next few lessons you will learn all about MemoryLeak and how to use it.


We are happy you joined us, and we hope you will find this website useful. ',
  '2017-01-01',
  '2017-01-01',
  'public',
  0,
  1,
  TRUE,
  FALSE
);

INSERT INTO categories (category_id, title, url) VALUES (0, 'starting-out', 'starting-out'),
  (1, 'tutorial', 'tutorial'),
  (2, 'memoryleak-official', 'memoryleak-official');

INSERT INTO virtual_class_categories (virtual_class_categories_id, virtual_class_id, category_id) VALUES
  (0, 0, 0),
  (1, 0, 1),
  (2, 0, 2);

INSERT INTO lectures (lecture_id, virtual_class_id, title, description, created, last_active, visibility, score, views, active, deleted)
VALUES
  (0, 0, 'Rules & Tips', 'General rules and tips about the website.', '2017-01-01', '2017-01-01', 'public', 0, 0, TRUE,
    FALSE),
  (1, 0, 'Markdown tutorial', 'A short markdown tutorial to get you started with asking and answering questions.',
    '2017-01-01', '2017-01-01', 'public', 0, 0, TRUE, FALSE),
  (2, 0, 'Offline functionality',
    'This website uses Service Workers to offer you limited functionality even when you are offline.', '2017-01-01',
    '2017-01-01', 'public', 0, 0, TRUE, FALSE);

INSERT INTO pages (page_id, lecture_id, title, content, created, last_active, visibility, score, views, active, deleted)
VALUES
  (0, 0, '', '**How to Ask**

----------

We’d love to help you, but the reality is that not every question gets answered. To improve your chances, here are some tips:

**Search, and research**
Have you thoroughly searched for an answer before asking your question? Sharing your research helps everyone. Tell us what you found (on this site or elsewhere) and why it didn’t meet your needs. This demonstrates that you’ve taken the time to try to help yourself, it saves us from reiterating obvious answers, and above all, it helps you get a more specific and relevant answer!

----------

**Be on-topic**
Our community is defined by a specific set of topics in the help center; please stick to those topics and avoid asking for opinions or open-ended discussion.

----------

**Be specific**
If you ask a vague question, you’ll get a vague answer. But if you give us details and context, we can provide a useful, relevant answer.

----------

**Make it relevant to others**
We like to help as many people at a time as we can. Make it clear how your question is relevant to more people than just you, and more of us will be interested in your question and willing to look into it.

----------

**Keep an open mind**
The answer to your question may not always be the one you wanted, but that doesn’t mean it is wrong. A conclusive answer isn’t always possible. When in doubt, ask people to cite their sources, or to explain how/where they learned something. Even if we don’t agree with you, or tell you exactly what you wanted to hear, remember: we’re just trying to help.',
    '2017-01-01', '2017-01-01', 'public', 0, 0, TRUE, FALSE);
INSERT INTO pages (page_id, lecture_id, title, content, created, last_active, visibility, score, views, active, deleted)
VALUES
  (1, 1, '', 'Markdown is a simple way to format text that looks great on any device. It doesn’t do anything fancy like change the font size, color, or type — just the essentials, using keyboard symbols you already know.

----------

**Type**:     \*Italic\* or \_Italic\_
**To get**:     *Italic*

**Type**:     \*\*Bold\*\* or \_\_Bold\_\_
**To get**:     **Bold**

**Type**:     \#\# Heading \#\#
 **To get**:

## Heading ##

**Type**:     \[enter link description here\]\[1\]
                     \[1\]: http://memoryleak.com

**To get**:     [enter link description here][1]


**Type**:     \!\[enter image description here\]\[2\]
                     \[2\]: http://localhost:8080/profileImage/admin.png

**To get**:      ![enter image description here][2]

**Type**:     \> Blockquote

**To get**:

> Blockquote

**Type**:

 1\. List item
 2\. List item

**To get**:

 1. List item
 2. List item

**Type**:

 \- List item
 \- List item

**To get**:

 - List item
 - List item

**Type**:
Horizontal Rule
\----------

**To get**:
Horizontal Rule

----------

**Type**:

····enter code here

**To get**:

    enter code here

  [1]: http://memoryleak.com
  [2]: http://localhost:8080/profileImage/admin.png', '2017-01-01', '2017-01-01', 'public', 0, 0, TRUE, FALSE);
INSERT INTO pages (page_id, lecture_id, title, content, created, last_active, visibility, score, views, active, deleted)
VALUES
  (2, 2, '', 'After you access a question, class or lecture, your browser will save that page so that you can access it even when you are offline.

This is new technology and not all browsers will support it, or some will only support it partially.

You can use [this site][1] to check if you browsers supports service workers, and will work offline or not. If your current version of browsers does not support it, we recommend updating to the latest version, or downloading a different browser.


  [1]: https://caniuse.com/#search=service%20workers', '2017-01-01', '2017-01-01', 'public', 0, 0, TRUE, FALSE);
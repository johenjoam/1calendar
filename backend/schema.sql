CREATE TABLE users (
    id  INTEGER PRIMARY KEY,
    auth_id TEXT UNIQUE,
    name  TEXT,
    username TEXT UNIQUE,
    birthday TEXT,
    email TEXT UNIQUE,
    acc_created_date TEXT,
    color TEXT
);

CREATE TABLE households (
    id INTEGER PRIMARY KEY,
    name TEXT,
    hh_made_date TEXT
);

CREATE TABLE household_members (
    id INTEGER PRIMARY KEY,
    household_id INTEGER,
    user_id INTEGER,
    user_role TEXT,
    join_date TEXT,
    FOREIGN KEY (household_id) REFERENCES households(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE events (
    id INTEGER PRIMARY KEY,
    household_id INTEGER,
    name TEXT,
    description TEXT,
    event_date TEXT,
    event_time TEXT,
    location TEXT,
    created_by INTEGER,
    recurrence TEXT,
    FOREIGN KEY (household_id) REFERENCES households(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE tasks (
    id INTEGER PRIMARY KEY,
    household_id INTEGER,
    name TEXT,
    description TEXT,
    due_date TEXT,
    completed_time TEXT,
    priority TEXT,
    status TEXT,
    recurrence TEXT,
    assigned_to INTEGER,
    assigned_by INTEGER,
    related_event_id INTEGER,
    FOREIGN KEY (household_id) REFERENCES households(id),
    FOREIGN KEY (assigned_to) REFERENCES users(id),
    FOREIGN KEY (assigned_by) REFERENCES users(id),
    FOREIGN KEY (related_event_id) REFERENCES events(id)
);

CREATE TABLE event_participants (
    id INTEGER PRIMARY KEY,
    event_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY (event_id) REFERENCES events(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE task_participants (
    id INTEGER PRIMARY KEY,
    task_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY (task_id) REFERENCES tasks(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE notifications (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    message TEXT,
    created_at TEXT,
    read_status TEXT,
    related_event_id INTEGER,
    related_task_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (related_event_id) REFERENCES events(id),
    FOREIGN KEY (related_task_id) REFERENCES tasks(id)
);

CREATE TABLE shopping_list (
    id INTEGER PRIMARY KEY,
    household_id INTEGER,
    claimed_by INTEGER,
    item_name TEXT,
    quantity INTEGER,
    purchased BOOLEAN,
    FOREIGN KEY (claimed_by) REFERENCES users(id),
    FOREIGN KEY (household_id) REFERENCES households(id)
);

CREATE TABLE expenses (
    id INTEGER PRIMARY KEY,
    household_id INTEGER,
    description TEXT,
    amount REAL,
    paid_by INTEGER,
    place TEXT,
    date TEXT,
    FOREIGN KEY (household_id) REFERENCES households(id),
    FOREIGN KEY (paid_by) REFERENCES users(id)
);

CREATE TABLE expenses_participants (
    id INTEGER PRIMARY KEY,
    expense_id INTEGER,
    user_id INTEGER,
    share_amount REAL,
    FOREIGN KEY (expense_id) REFERENCES expenses(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

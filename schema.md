# FitTrack Pro Database Schema

```mermaid
erDiagram
    LOCATIONS {
        location_id
        name
        address
        phone_number
        email
        opening_hours
    }
    MEMBERS {
        member_id
        first_name
        last_name
        email
        phone_number
        date_of_birth
        join_date
        emergency_contact_name
        emergency_contact_phone
    }
    STAFF {
        staff_id
        first_name
        last_name
        email
        phone_number
        position
        hire_date
        location_id
    }
    EQUIPMENT {
        equipment_id
        name
        type
        purchase_date
        last_maintenance_date
        next_maintenance_date
        location_id
    }
    CLASSES {
        class_id
        name
        description
        capacity
        duration
        location_id
    }
    CLASS_SCHEDULE {
        schedule_id
        class_id
        staff_id
        start_time
        end_time
    }
    MEMBERSHIPS {
        membership_id
        member_id
        type
        start_date
        end_date
        status
    }
    ATTENDANCE {
        attendance_id
        member_id
        location_id
        check_in_time
        check_out_time
    }
    CLASS_ATTENDANCE {
        class_attendance_id
        schedule_id
        member_id
        attendance_status
    }
    PAYMENTS {
        payment_id
        member_id
        amount
        payment_date
        payment_method
        description
    }
    PERSONAL_TRAINING_SESSIONS {
        session_id
        member_id
        staff_id
        session_date
        start_time
        end_time
        notes
    }
    MEMBER_HEALTH_METRICS {
        metric_id
        member_id
        measurement_date
        weight
        body_fat_percentage
        muscle_mass
        bmi
    }
    EQUIPMENT_MAINTENANCE_LOG {
        log_id
        equipment_id
        maintenance_date
        description
        staff_id
    }
```

## Interpreting the Schema

1. Entities: Each table in the database is represented as an entity (box) in the diagram. For example, LOCATIONS, MEMBERS, STAFF, and EQUIPMENT are all entities in our FitTrack Pro schema.
2. Attributes: The attributes (columns) of each entity are listed within the entity box. The data type of each attribute is also specified. For instance, the MEMBERS entity has attributes like member_id, first_name, last_name, email, etc.
3. Primary Keys: Primary keys are indicated with "PK" after the attribute name. For example, in the LOCATIONS entity, location_id is marked with PK, indicating it's the primary key for that table.
4. Foreign Keys: Foreign keys are indicated with "FK" after the attribute name. For instance, in the STAFF entity, location_id is marked with FK, showing it's a foreign key referencing the LOCATIONS table.
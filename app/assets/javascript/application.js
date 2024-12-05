
// Import necessary dependencies
import "@hotwired/turbo-rails";
import "./controllers";
import * as bootstrap from "bootstrap"; // Assuming you are using Bootstrap
import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid"; // DayGrid view plugin
import interactionPlugin from "@fullcalendar/interaction"; // Enable interactivity like clicking
import timeGridPlugin from "@fullcalendar/timegrid"; // For time-grid views
import listPlugin from "@fullcalendar/list"; // For list views


document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    if (calendarEl) {
      var teamId = calendarEl.getAttribute('data-team-id'); // Fetch team ID from the data attribute
  
      var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        events: `/teams/${teamId}/events_json`, // Use dynamic team ID
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        eventDisplay: 'block', // Ensures events are displayed with their titles
        timeZone: 'local', // Adjust for time zones if needed
  
        // Customize the way events are displayed
        eventContent: function(eventInfo) {
          return {
            html: `
              <b>${eventInfo.event.title}</b><br>
              <small>${eventInfo.event.extendedProps.location || ''}</small>
            `
          };
        },
  
        // Handle clicking on events
        eventClick: function(info) {
          alert(`Event: ${info.event.title}\nLocation: ${info.event.extendedProps.location || 'Not specified'}`);
        }
      });
  
      calendar.render(); // Render the calendar
    }
  });